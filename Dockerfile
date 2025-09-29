# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Production stage
FROM node:18-alpine AS production

# Create app user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodeapp -u 1001

# Set working directory
WORKDIR /app

# Copy built dependencies
COPY --from=builder /app/node_modules ./node_modules

# Copy application code
COPY --chown=nodeapp:nodejs . .

# Create logs directory
RUN mkdir -p logs && chown nodeapp:nodejs logs

# Switch to non-root user
USER nodeapp

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => { process.exit(r.statusCode === 200 ? 0 : 1) })"

# Default command
CMD ["npm", "start"]
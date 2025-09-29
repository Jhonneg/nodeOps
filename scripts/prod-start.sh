#!/bin/bash

# NodeOps Production Startup Script
# This script starts the production environment with Neon Cloud Database

set -e

echo "🚀 Starting NodeOps Production Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if .env.production exists
if [ ! -f ".env.production" ]; then
    echo "❌ .env.production file not found. Please create it first."
    echo "   Make sure to configure your Neon Cloud Database URL."
    exit 1
fi

# Validate required environment variables
source .env.production

if [ -z "$DATABASE_URL" ]; then
    echo "❌ DATABASE_URL not found in .env.production"
    echo "   Please configure your Neon Cloud Database URL."
    exit 1
fi

if [ -z "$JWT_SECRET" ]; then
    echo "❌ JWT_SECRET not found in .env.production"
    echo "   Please configure a secure JWT secret."
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Run database migrations
echo "🔄 Running database migrations..."
npm run db:migrate

# Start the production environment
echo "📦 Building and starting containers..."
docker-compose -f docker-compose.prod.yml up --build -d

# Wait for services to be healthy
echo "⏳ Waiting for services to start..."
sleep 15

# Check service health
if docker-compose -f docker-compose.prod.yml ps | grep -q "Up (healthy)"; then
    echo "✅ Production environment started successfully!"
    echo ""
    echo "📍 Available services:"
    echo "   🌐 Application: http://localhost:3000"
    echo "   📊 Health Check: http://localhost:3000/health"
    echo ""
    echo "🔐 Security notes:"
    echo "   - Application runs as non-root user"
    echo "   - Container filesystem is read-only"
    echo "   - Resource limits are applied"
    echo ""
    echo "📝 View logs: docker-compose -f docker-compose.prod.yml logs -f"
    echo "🛑 Stop: docker-compose -f docker-compose.prod.yml down"
    echo ""
    echo "🚨 Optional services:"
    echo "   - Nginx: docker-compose -f docker-compose.prod.yml --profile nginx up -d"
    echo "   - Monitoring: docker-compose -f docker-compose.prod.yml --profile monitoring up -d"
else
    echo "⚠️  Some services may not be ready yet. Check logs:"
    docker-compose -f docker-compose.prod.yml logs
fi
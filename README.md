# NodeOps

<div align="center">
  <h3>🚀 Backend & DevOps Showcase Project</h3>
  <p>A production-ready Node.js REST API with authentication, built with modern tools and best practices</p>
</div>

## 🛠️ Tech Stack

### Backend

[![Backend Technologies](https://skillicons.dev/icons?i=js,nodejs,express,postgres)](https://skillicons.dev)

- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **PostgreSQL** - Primary database
- **Neon** - Serverless PostgreSQL platform

### Database & ORM

[![Database](https://skillicons.dev/icons?i=postgres)](https://skillicons.dev)

- **Drizzle ORM** - Type-safe SQL query builder
- **Drizzle Kit** - Database migrations and introspection

### Security & Authentication

- **JWT** - JSON Web Tokens for authentication
- **bcryptjs** - Password hashing
- **Helmet** - Security middleware
- **CORS** - Cross-origin resource sharing

### Validation & Logging

- **Zod** - TypeScript-first schema validation
- **Winston** - Logging library
- **Morgan** - HTTP request logger

### Development Tools

- **ESLint** - Code linting
- **Prettier** - Code formatting

### DevOps (Planned)

[![DevOps](https://skillicons.dev/icons?i=docker,kubernetes,bash)](https://skillicons.dev)

- **Docker** - Containerization
- **Kubernetes** - Container orchestration
- **Bash** - Automation scripts

## 🏗️ Architecture

The project follows a **layered architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│              HTTP Requests              │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│         Controllers Layer               │
│    (Request/Response handling)          │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│          Services Layer                 │
│      (Business Logic)                   │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│          Models Layer                   │
│    (Database Schema & Queries)          │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│        PostgreSQL Database              │
└─────────────────────────────────────────┘
```

### Directory Structure

```
src/
├── config/          # Configuration files
│   ├── database.js   # Database connection
│   └── logger.js     # Winston logger setup
├── controllers/     # Request handlers
│   └── auth.controller.js
├── models/          # Database schemas
│   └── user.model.js
├── routes/          # API routes
│   └── auth.routes.js
├── services/        # Business logic
│   └── auth.service.js
├── utils/           # Utility functions
│   ├── cookies.js   # Cookie management
│   ├── format.js    # Error formatting
│   └── jwt.js       # JWT utilities
├── validations/     # Input validation schemas
│   └── auth.validation.js
├── app.js           # Express app configuration
├── server.js        # Server setup
└── index.js         # Application entry point
```

## 🚀 Getting Started

### Prerequisites

- **Node.js** (v18 or higher)
- **PostgreSQL** database (or Neon account)
- **npm** or **yarn**

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Jhonneg/nodeOps.git
   cd nodeOps
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Environment Setup**
   Create a `.env` file in the root directory:

   ```env
   # Database
   DATABASE_URL=postgresql://username:password@localhost:5432/nodeops

   # JWT
   JWT_SECRET=your-super-secret-jwt-key-here

   # Server
   PORT=3000
   NODE_ENV=development

   # Logging
   LOG_LEVEL=info
   ```

4. **Database Setup**

   ```bash
   # Generate migration files
   npm run db:generate

   # Run migrations
   npm run db:migrate

   # (Optional) Open Drizzle Studio
   npm run db:studio
   ```

5. **Start Development Server**
   ```bash
   npm run dev
   ```

The server will start on `http://localhost:3000`

## 🐳 Docker Setup

### Overview

NodeOps supports both **development** and **production** Docker environments:

- **Development**: Uses **Neon Local** via Docker for local PostgreSQL with ephemeral branches
- **Production**: Connects to **Neon Cloud Database** for scalable serverless PostgreSQL

### Prerequisites

- **Docker** (v20.10 or higher)
- **Docker Compose** (v2.0 or higher)
- **Neon Account** (for production)

### 🔧 Development Environment

#### Quick Start (Recommended)

```bash
# Start development environment with Neon Local
npm run docker:dev

# Or use the script directly
./scripts/dev-start.sh
```

#### Manual Setup

1. **Configure Environment**
   ```bash
   # .env.development is already configured for Neon Local
   cp .env.development .env.development.local  # Optional: customize
   ```

2. **Start Services**
   ```bash
   # Build and start all development services
   docker-compose -f docker-compose.dev.yml up --build -d
   
   # Start with database administration tools
   docker-compose -f docker-compose.dev.yml --profile tools up -d
   ```

3. **Access Services**
   - **Application**: http://localhost:3000
   - **Health Check**: http://localhost:3000/health
   - **PostgreSQL**: `localhost:5432` (postgres/postgres)
   - **pgAdmin**: http://localhost:8080 (admin@nodeops.local/admin123)

#### Development Features

✅ **Neon Local Integration**: Local PostgreSQL proxy mimicking Neon's behavior  
✅ **Hot Reload**: Source code changes reflected immediately  
✅ **Database Tools**: pgAdmin for database management  
✅ **Ephemeral Branches**: Automatic branch creation for testing  
✅ **Volume Persistence**: Data persists between container restarts  

### 🚀 Production Environment

#### Setup Neon Cloud Database

1. **Create Neon Project**
   - Go to [Neon Console](https://console.neon.tech)
   - Create a new project
   - Copy the connection string

2. **Configure Environment**
   ```bash
   # Copy and customize production environment
   cp .env.production .env.production.local
   
   # Edit .env.production.local with your Neon Cloud credentials
   DATABASE_URL=postgresql://username:password@ep-xxx-xxx.us-east-2.aws.neon.tech/nodeops?sslmode=require
   JWT_SECRET=your-super-secure-production-secret
   ```

#### Deploy to Production

```bash
# Quick start (uses .env.production)
npm run docker:prod

# Or use the script directly
./scripts/prod-start.sh
```

#### Manual Production Deployment

1. **Run Database Migrations**
   ```bash
   npm run db:migrate
   ```

2. **Start Production Services**
   ```bash
   # Basic production setup
   docker-compose -f docker-compose.prod.yml up --build -d
   
   # With Nginx reverse proxy
   docker-compose -f docker-compose.prod.yml --profile nginx up -d
   
   # With monitoring (Filebeat)
   docker-compose -f docker-compose.prod.yml --profile monitoring up -d
   ```

#### Production Features

🔒 **Security Hardened**: Non-root user, read-only filesystem, capability dropping  
⚡ **Resource Optimized**: Memory and CPU limits applied  
🔄 **Health Checks**: Automatic container health monitoring  
📊 **Monitoring Ready**: Optional Filebeat integration for log aggregation  
🌐 **Reverse Proxy Ready**: Optional Nginx configuration for SSL termination  

### 🛠️ Docker Commands Reference

#### Development Commands
```bash
# Start development environment
npm run docker:dev                    # Full startup script
npm run docker:dev:up                 # Start containers only
npm run docker:dev:build              # Build images only
npm run docker:dev:down               # Stop and remove containers
npm run docker:dev:logs               # View live logs

# With database tools
docker-compose -f docker-compose.dev.yml --profile tools up -d
```

#### Production Commands
```bash
# Start production environment
npm run docker:prod                   # Full startup script
npm run docker:prod:up                # Start containers only
npm run docker:prod:build             # Build images only
npm run docker:prod:down              # Stop and remove containers
npm run docker:prod:logs              # View live logs

# With additional services
docker-compose -f docker-compose.prod.yml --profile nginx up -d
docker-compose -f docker-compose.prod.yml --profile monitoring up -d
```

#### Utility Commands
```bash
# View container status
docker-compose -f docker-compose.dev.yml ps
docker-compose -f docker-compose.prod.yml ps

# Execute commands in containers
docker-compose -f docker-compose.dev.yml exec app bash
docker-compose -f docker-compose.dev.yml exec neon-local psql -U postgres -d nodeops_dev

# Clean up everything
docker-compose -f docker-compose.dev.yml down -v --rmi all
docker-compose -f docker-compose.prod.yml down -v --rmi all
```

### 🗂️ Docker Files Structure

```
.
├── Dockerfile                    # Multi-stage Node.js application image
├── .dockerignore                # Optimize build context
├── docker-compose.dev.yml       # Development with Neon Local
├── docker-compose.prod.yml      # Production with Neon Cloud
├── .env.development             # Development environment variables
├── .env.production              # Production environment template
└── scripts/
    ├── dev-start.sh            # Development startup script
    └── prod-start.sh           # Production startup script
```

### 🔍 Environment Variables

#### Development (.env.development)
```env
DATABASE_URL=postgresql://postgres:postgres@neon-local:5432/nodeops_dev
JWT_SECRET=dev-super-secret-jwt-key-change-in-production
NODE_ENV=development
LOG_LEVEL=debug
```

#### Production (.env.production)
```env
DATABASE_URL=postgresql://user:pass@ep-xxx.neon.tech/nodeops?sslmode=require
JWT_SECRET=your-production-jwt-secret
NODE_ENV=production
LOG_LEVEL=info
```

### 🚨 Troubleshooting

#### Common Issues

**Database Connection Issues**
```bash
# Check database connectivity
docker-compose -f docker-compose.dev.yml exec app npm run db:studio
docker-compose -f docker-compose.dev.yml exec neon-local pg_isready
```

**Container Health Issues**
```bash
# Check container health
docker-compose -f docker-compose.dev.yml ps
docker inspect nodeops-app-dev --format='{{.State.Health.Status}}'
```

**Log Analysis**
```bash
# Application logs
docker-compose -f docker-compose.dev.yml logs app

# Database logs
docker-compose -f docker-compose.dev.yml logs neon-local

# All services logs
docker-compose -f docker-compose.dev.yml logs -f
```

#### Reset Development Environment
```bash
# Complete reset (removes all data)
docker-compose -f docker-compose.dev.yml down -v
docker system prune -f
npm run docker:dev
```

### 📈 Performance Considerations

#### Development
- **Volume Mounts**: Source code is mounted for hot reload
- **Debug Logging**: More verbose logging for debugging
- **No Resource Limits**: Maximum performance for development

#### Production
- **Read-Only Filesystem**: Enhanced security
- **Resource Limits**: 512MB RAM, 0.5 CPU cores
- **Health Checks**: Automatic restart on failure
- **Multi-layered Security**: Non-root user, capability dropping

### 🌐 Deployment Options

#### Local Development
```bash
git clone https://github.com/Jhonneg/nodeOps.git
cd nodeOps
npm run docker:dev
```

#### Production Server
```bash
# On your production server
git clone https://github.com/Jhonneg/nodeOps.git
cd nodeOps

# Configure production environment
cp .env.production .env.production.local
vim .env.production.local  # Add your Neon Cloud URL

# Deploy
npm run docker:prod
```

#### Cloud Platforms
The production Docker setup is compatible with:
- **AWS ECS/Fargate**
- **Google Cloud Run**
- **Azure Container Instances**
- **DigitalOcean App Platform**
- **Railway**
- **Render**

### 🔐 Security Best Practices

✅ **Non-root User**: Application runs as `nodeapp` user  
✅ **Read-only Filesystem**: Container filesystem is immutable  
✅ **Capability Dropping**: Minimal Linux capabilities  
✅ **Resource Limits**: Memory and CPU constraints  
✅ **Health Monitoring**: Automatic failure detection  
✅ **Secret Management**: Environment-based configuration  
✅ **Network Isolation**: Dedicated Docker networks  

## 📡 API Documentation

### Base URL

```
http://localhost:3000/api
```

### Health Check

```http
GET /health
```

**Response:**

```json
{
  "status": "OK",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "uptime": 123.45
}
```

### Authentication Endpoints

#### User Registration

```http
POST /api/auth/sign-up
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securepassword123",
  "role": "user"
}
```

**Success Response (201):**

```json
{
  "message": "User registered",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  }
}
```

#### User Login

```http
POST /api/auth/sign-in
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "securepassword123"
}
```

**Success Response (200):**

```json
{
  "message": "User signed in successfully",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  }
}
```

#### User Logout

```http
POST /api/auth/sign-out
```

**Success Response (200):**

```json
{
  "message": "User signed out successfully"
}
```

### Error Responses

**Validation Error (400):**

```json
{
  "error": "Validation failed",
  "details": "Email must be a valid email address"
}
```

**Authentication Error (401):**

```json
{
  "error": "Invalid email or password"
}
```

**Conflict Error (409):**

```json
{
  "error": "Email already exists"
}
```

## 🧪 Available Scripts

```bash
# Development
npm run dev          # Start development server with hot reload

# Code Quality
npm run lint         # Run ESLint
npm run lint:fix     # Fix ESLint issues automatically
npm run format       # Format code with Prettier
npm run format:check # Check code formatting

# Database
npm run db:generate  # Generate migration files
npm run db:migrate   # Run database migrations
npm run db:studio    # Open Drizzle Studio (database GUI)

# Testing
npm test            # Run tests (not implemented yet)
```

## 🔐 Security Features

- **Password Hashing**: bcrypt with salt rounds
- **JWT Authentication**: Secure token-based authentication
- **HTTP-Only Cookies**: Secure token storage
- **Input Validation**: Zod schema validation
- **Security Headers**: Helmet middleware
- **CORS Protection**: Configurable cross-origin policies
- **Error Handling**: Sanitized error messages

## 📝 Environment Variables

| Variable       | Description                  | Default       | Required |
| -------------- | ---------------------------- | ------------- | -------- |
| `DATABASE_URL` | PostgreSQL connection string | -             | ✅       |
| `JWT_SECRET`   | JWT signing secret           | -             | ✅       |
| `PORT`         | Server port                  | `3000`        | ❌       |
| `NODE_ENV`     | Environment mode             | `development` | ❌       |
| `LOG_LEVEL`    | Logging level                | `info`        | ❌       |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Use ESLint and Prettier configurations
- Follow existing patterns and conventions
- Write meaningful commit messages
- Add proper error handling and logging

## 📊 Project Status

### ✅ Completed Features

- User registration and authentication
- JWT token management
- Secure password handling
- Input validation
- Comprehensive logging
- Database integration with Drizzle ORM
- Clean architecture implementation

### 🚧 Planned Features

- [ ] Password reset functionality
- [ ] Email verification
- [ ] Role-based access control (RBAC)
- [ ] Rate limiting
- [ ] API documentation with Swagger
- [ ] Unit and integration tests
- [ ] Docker containerization
- [ ] Kubernetes deployment manifests
- [ ] CI/CD pipeline
- [ ] Monitoring and metrics

## 📄 License

This project is licensed under the ISC License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Jhonneg**

- GitHub: [@Jhonneg](https://github.com/Jhonneg)
- Project Link: [https://github.com/Jhonneg/nodeOps](https://github.com/Jhonneg/nodeOps)

---

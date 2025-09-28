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
[![Dev Tools](https://skillicons.dev/icons?i=eslint,prettier)](https://skillicons.dev)
- **ESLint** - Code linting
- **Prettier** - Code formatting
- **Nodemon** - Development server with hot reload

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

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `DATABASE_URL` | PostgreSQL connection string | - | ✅ |
| `JWT_SECRET` | JWT signing secret | - | ✅ |
| `PORT` | Server port | `3000` | ❌ |
| `NODE_ENV` | Environment mode | `development` | ❌ |
| `LOG_LEVEL` | Logging level | `info` | ❌ |

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

<div align="center">
  <p>⭐ Star this repository if you find it helpful!</p>
</div>

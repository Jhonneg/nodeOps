#!/bin/bash

# NodeOps Development Startup Script
# This script starts the development environment with Neon Local

set -e

echo "🚀 Starting NodeOps Development Environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if .env.development exists
if [ ! -f ".env.development" ]; then
    echo "❌ .env.development file not found. Please create it first."
    echo "   You can copy from .env.development.example if available."
    exit 1
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Start the development environment
echo "📦 Building and starting containers..."
docker-compose -f docker-compose.dev.yml up --build -d

# Wait for services to be healthy
echo "⏳ Waiting for services to start..."
sleep 10

# Check service health
if docker-compose -f docker-compose.dev.yml ps | grep -q "Up (healthy)"; then
    echo "✅ Development environment started successfully!"
    echo ""
    echo "📍 Available services:"
    echo "   🌐 Application: http://localhost:3000"
    echo "   📊 Health Check: http://localhost:3000/health"
    echo "   🗄️  Database: localhost:5432 (postgres/postgres)"
    echo ""
    echo "🛠️  Optional services (use --profile tools):"
    echo "   📊 pgAdmin: http://localhost:8080 (admin@nodeops.local/admin123)"
    echo ""
    echo "📝 View logs: docker-compose -f docker-compose.dev.yml logs -f"
    echo "🛑 Stop: docker-compose -f docker-compose.dev.yml down"
else
    echo "⚠️  Some services may not be ready yet. Check logs:"
    docker-compose -f docker-compose.dev.yml logs
fi
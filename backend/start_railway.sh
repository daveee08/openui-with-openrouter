#!/bin/bash

# Railway startup script for OpenUI
# This script handles the Railway-specific deployment requirements

echo "Starting OpenUI deployment on Railway..."

# Set Railway-specific environment variables
export PYTHONPATH="/app/backend:$PYTHONPATH"
export DATA_DIR="/app/backend/data"
export UPLOAD_DIR="/app/backend/data/uploads"
export CACHE_DIR="/app/backend/data/cache"
export FRONTEND_BUILD_DIR="/app/build"
export STATIC_DIR="/app/backend/open_webui/static"

# Use Railway's PORT environment variable
export PORT=${PORT:-8080}

# Create necessary directories
mkdir -p $DATA_DIR
mkdir -p $UPLOAD_DIR
mkdir -p $CACHE_DIR

echo "Environment variables set:"
echo "  PYTHONPATH: $PYTHONPATH"
echo "  DATA_DIR: $DATA_DIR"
echo "  FRONTEND_BUILD_DIR: $FRONTEND_BUILD_DIR"
echo "  PORT: $PORT"

# Check if frontend build exists
if [ ! -d "$FRONTEND_BUILD_DIR" ]; then
    echo "Frontend build directory not found. Creating placeholder..."
    mkdir -p $FRONTEND_BUILD_DIR
    echo '<!DOCTYPE html><html><head><title>OpenUI</title></head><body><h1>OpenUI is starting...</h1></body></html>' > $FRONTEND_BUILD_DIR/index.html
fi

# Change to backend directory
cd /app/backend

# Run database migrations if DATABASE_URL is available
if [ ! -z "$DATABASE_URL" ]; then
    echo "Running database migrations..."
    python -m alembic upgrade head || echo "Migration failed or not needed, continuing..."
else
    echo "No DATABASE_URL found, skipping migrations..."
fi

# Start the application
echo "Starting OpenUI server on port $PORT..."
exec python -m uvicorn open_webui.main:app --host 0.0.0.0 --port $PORT --workers 1

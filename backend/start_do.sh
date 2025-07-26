#!/bin/bash

# Set environment variables
export PYTHONPATH="/app/backend:$PYTHONPATH"
export DATA_DIR="/app/backend/data"
export UPLOAD_DIR="/app/backend/data/uploads"
export CACHE_DIR="/app/backend/data/cache"
export FRONTEND_BUILD_DIR="/app/build"
export STATIC_DIR="/app/backend/open_webui/static"

# Create data directories if they don't exist
mkdir -p $DATA_DIR
mkdir -p $UPLOAD_DIR
mkdir -p $CACHE_DIR

# Ensure the frontend build directory exists
if [ ! -d "$FRONTEND_BUILD_DIR" ]; then
    echo "Frontend build directory not found. Creating empty directory..."
    mkdir -p $FRONTEND_BUILD_DIR
fi

# Change to backend directory
cd /app/backend

# Run database migrations if DATABASE_URL is set
if [ ! -z "$DATABASE_URL" ]; then
    echo "Running database migrations..."
    python -m alembic upgrade head
else
    echo "No DATABASE_URL set, skipping migrations..."
fi

# Start the application
echo "Starting OpenUI application..."
exec uvicorn open_webui.main:app --host 0.0.0.0 --port 8080 --workers 1

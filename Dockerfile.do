# DigitalOcean App Platform Dockerfile (for reference/local testing)
# This is not used by App Platform directly, but can be useful for local testing

FROM node:18-alpine AS frontend-builder

WORKDIR /app

# Copy frontend files
COPY package*.json ./
COPY . .

# Install dependencies and build frontend
RUN npm install
RUN npm run build

FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy backend files
COPY backend/ ./backend/
COPY --from=frontend-builder /app/build ./build

# Install Python dependencies
RUN pip install -r backend/requirements.txt

# Create necessary directories
RUN mkdir -p /app/backend/data/uploads /app/backend/data/cache

# Make startup script executable
RUN chmod +x backend/start_do.sh

# Set environment variables
ENV PYTHONPATH="/app/backend"
ENV FRONTEND_BUILD_DIR="/app/build"
ENV DATA_DIR="/app/backend/data"
ENV UPLOAD_DIR="/app/backend/data/uploads"
ENV CACHE_DIR="/app/backend/data/cache"

EXPOSE 8080

CMD ["./backend/start_do.sh"]

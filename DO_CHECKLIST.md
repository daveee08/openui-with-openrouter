# DigitalOcean Deployment Checklist

## Pre-Deployment
- [ ] Code pushed to GitHub repository
- [ ] `.do/app-simple.yaml` configuration file created
- [ ] `backend/start_do.sh` script is executable
- [ ] S3-compatible storage bucket created
- [ ] S3 access credentials obtained

## DigitalOcean Setup
- [ ] DigitalOcean account created
- [ ] Repository connected to App Platform
- [ ] App spec uploaded/configured
- [ ] Environment variables configured:
  - [ ] `WEBUI_SECRET_KEY` (required)
  - [ ] `S3_BUCKET_NAME` (required if using S3 storage)
  - [ ] `S3_ACCESS_KEY_ID` (required if using S3 storage)
  - [ ] `S3_SECRET_ACCESS_KEY` (required if using S3 storage)
  - [ ] `S3_REGION_NAME` (required if using S3 storage)
  - [ ] `S3_ENDPOINT_URL` (required if using S3 storage)
  - [ ] AI API keys (optional but recommended)

## Post-Deployment
- [ ] Application successfully deployed
- [ ] Health check endpoint responding: `https://your-app.ondigitalocean.app/health`
- [ ] Database migrations completed
- [ ] First admin user created
- [ ] Basic functionality tested:
  - [ ] User registration/login
  - [ ] File upload (if using S3 storage)
  - [ ] AI model integration
  - [ ] Chat functionality

## Production Configuration
- [ ] Custom domain configured (optional)
- [ ] SSL certificate configured
- [ ] CORS origins updated for production domain
- [ ] Monitoring and alerts configured
- [ ] Backup strategy verified

## Environment Variables Reference

### Required
```
WEBUI_SECRET_KEY=your-secure-secret-key
DATABASE_URL=${db.DATABASE_URL}  # Auto-provided by DigitalOcean
```

### Storage (choose one)
```
# For S3/DigitalOcean Spaces
STORAGE_PROVIDER=s3
S3_BUCKET_NAME=your-bucket-name
S3_ACCESS_KEY_ID=your-access-key
S3_SECRET_ACCESS_KEY=your-secret-key
S3_REGION_NAME=us-east-1
S3_ENDPOINT_URL=https://s3.amazonaws.com

# For local storage (not recommended for production)
STORAGE_PROVIDER=local
```

### AI API Keys (optional)
```
OPENAI_API_KEY=your-openai-key
ANTHROPIC_API_KEY=your-anthropic-key
GOOGLE_API_KEY=your-google-key
```

### Application Settings
```
ENABLE_SIGNUP=True
DEFAULT_USER_ROLE=pending
CORS_ALLOW_ORIGIN=*  # Update for production
```

## Useful Commands

### Local Testing
```bash
# Build frontend
npm run build

# Start backend (after setting environment variables)
cd backend
python -m uvicorn open_webui.main:app --host 0.0.0.0 --port 8080
```

### Debugging
```bash
# Check health
curl https://your-app.ondigitalocean.app/health

# Check database health
curl https://your-app.ondigitalocean.app/health/db
```

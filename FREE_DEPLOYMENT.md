# Free Deployment Guide for OpenUI

## Best Free Options (Ranked by Ease)

### 1. 🥇 Railway (Recommended)
- **Free Tier**: $5 credit/month (usually sufficient)
- **Setup Time**: 5 minutes
- **Database**: Free PostgreSQL included
- **File Storage**: Persistent disk (limited)

#### Railway Quick Setup:
1. Go to [railway.app](https://railway.app) and sign up with GitHub
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your `openui-with-openrouter` repository
4. Railway will auto-detect it as a Python app
5. Add PostgreSQL service: Click "New" → "Database" → "PostgreSQL"
6. Set environment variables in Railway dashboard:
   ```
   WEBUI_SECRET_KEY=your-random-secret-key-here
   STORAGE_PROVIDER=local
   DATABASE_URL=${Postgres.DATABASE_URL}
   PYTHONPATH=/app/backend
   FRONTEND_BUILD_DIR=/app/build
   ```
7. Deploy! 🚀

**Pro tip**: Railway automatically sets `PORT` and `DATABASE_URL`

### 2. 🥈 Render
- **Free Tier**: Service sleeps after 15min inactivity
- **Setup Time**: 10 minutes
- **Database**: Free PostgreSQL (90 days, then $7/month)

#### Render Quick Setup:
1. Go to [render.com](https://render.com)
2. Create "Web Service" from GitHub
3. Build Command: `npm install && npm run build && cd backend && pip install -r requirements.txt`
4. Start Command: `cd backend && python -m uvicorn open_webui.main:app --host 0.0.0.0 --port $PORT`
5. Add PostgreSQL database (free for 90 days)
6. Set environment variables

### 3. 🥉 Fly.io
- **Free Tier**: 3 shared VMs, 3GB storage
- **Setup Time**: 15 minutes (requires Docker knowledge)
- **Database**: Need external provider

### 4. Heroku Alternative: Back4App
- **Free Tier**: 25k requests/month
- **Database**: MongoDB/PostgreSQL included
- **Good for**: Small projects

## Storage Solutions for Free Deployments

### Free File Storage Options:
1. **Cloudflare R2**: 10GB free/month
2. **Backblaze B2**: 10GB free
3. **Supabase Storage**: 1GB free
4. **Firebase Storage**: 1GB free

### Configuration for External Storage:
```env
STORAGE_PROVIDER=s3
S3_BUCKET_NAME=your-bucket-name
S3_ACCESS_KEY_ID=your-key
S3_SECRET_ACCESS_KEY=your-secret
S3_ENDPOINT_URL=your-provider-endpoint
S3_REGION_NAME=auto
```

## Complete Free Stack Recommendation

**For Development/Testing:**
- **Hosting**: Railway ($5 credit/month)
- **Database**: Railway PostgreSQL (included)
- **Storage**: Local storage or Cloudflare R2 (10GB free)
- **Domain**: Railway subdomain (custom domain available)

**For Production (Low Traffic):**
- **Hosting**: Render ($0, sleeps when inactive)
- **Database**: Supabase PostgreSQL (500MB free)
- **Storage**: Cloudflare R2 (10GB free)
- **Domain**: Custom domain with Cloudflare

## Environment Variables for Free Deployment

### Minimal Setup (Local Storage):
```env
WEBUI_SECRET_KEY=your-very-secure-secret-key-at-least-32-characters-long
DATABASE_URL=postgresql://user:pass@host:port/db
STORAGE_PROVIDER=local
PYTHONPATH=/app/backend
FRONTEND_BUILD_DIR=/app/build
DATA_DIR=/app/backend/data
UPLOAD_DIR=/app/backend/data/uploads
CACHE_DIR=/app/backend/data/cache
```

### With External Storage:
```env
# Add these to the minimal setup above
STORAGE_PROVIDER=s3
S3_BUCKET_NAME=your-bucket
S3_ACCESS_KEY_ID=your-key
S3_SECRET_ACCESS_KEY=your-secret
S3_ENDPOINT_URL=https://your-provider.com
S3_REGION_NAME=auto
```

## Limitations of Free Hosting

### Common Limitations:
- **Cold Starts**: Apps sleep when inactive (Render, Heroku)
- **Resource Limits**: CPU, RAM, and storage restrictions
- **Build Time**: Limited build minutes per month
- **Bandwidth**: Monthly transfer limits
- **Custom Domains**: May require paid plans

### Workarounds:
- **Keep-Alive Services**: Use uptimerobot.com to ping your app
- **Optimize Build**: Use build caches, smaller dependencies
- **CDN**: Use Cloudflare for static assets
- **Database Pooling**: Optimize database connections

## Migration Path

### Start Free → Scale Paid:
1. **Start**: Railway free tier
2. **Growth**: Railway Pro ($5-20/month)
3. **Scale**: DigitalOcean App Platform ($25-50/month)
4. **Enterprise**: AWS/GCP with dedicated resources

## Quick Commands for Local Testing

```bash
# Install dependencies
npm install
cd backend && pip install -r requirements.txt

# Build frontend
npm run build

# Set environment variables (create .env file)
echo "WEBUI_SECRET_KEY=your-secret-key" > backend/.env
echo "STORAGE_PROVIDER=local" >> backend/.env

# Run locally
cd backend
python -m uvicorn open_webui.main:app --host 0.0.0.0 --port 8080
```

## Need Help?

1. **Railway Issues**: Check Railway docs or Discord
2. **Render Issues**: Check Render community forum
3. **General Issues**: Open issue in your GitHub repo
4. **Storage Issues**: Check your storage provider documentation

**Recommendation**: Start with Railway for the easiest free deployment experience!

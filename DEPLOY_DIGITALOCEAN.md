# Deploying OpenUI to DigitalOcean App Platform

This guide will help you deploy your OpenUI application to DigitalOcean App Platform.

## Prerequisites

1. A DigitalOcean account
2. Your code pushed to a GitHub repository
3. S3-compatible storage (AWS S3, DigitalOcean Spaces, etc.) for file uploads

## Deployment Steps

### 1. Prepare Your Repository

Make sure your code is pushed to GitHub and includes:
- The `.do/app-simple.yaml` configuration file
- The `backend/start_do.sh` startup script
- All necessary dependencies in `backend/requirements.txt`

### 2. Set Up Storage (Recommended)

Before deploying, set up S3-compatible storage:

**Option A: DigitalOcean Spaces**
1. Go to your DigitalOcean dashboard
2. Create a new Space (object storage)
3. Note the endpoint, access key, and secret key

**Option B: AWS S3**
1. Create an S3 bucket
2. Create IAM user with S3 access
3. Note the access key and secret key

### 3. Deploy to DigitalOcean App Platform

1. **Go to the DigitalOcean App Platform**
   - Visit: https://cloud.digitalocean.com/apps
   - Click "Create App"

2. **Connect Your Repository**
   - Choose "GitHub"
   - Select your repository
   - Choose the `main` branch

3. **Use App Spec**
   - Choose "Edit your app spec"
   - Copy the contents of `.do/app-simple.yaml`
   - Update the following values:
     ```yaml
     github:
       repo: YOUR_GITHUB_USERNAME/openui-with-openrouter
       branch: main
     ```

4. **Configure Environment Variables**
   
   Update these values in the app spec or add them in the DigitalOcean dashboard:

   **Required:**
   ```
   WEBUI_SECRET_KEY=your-secure-random-string-here
   S3_BUCKET_NAME=your-bucket-name
   S3_ACCESS_KEY_ID=your-access-key
   S3_SECRET_ACCESS_KEY=your-secret-key
   S3_REGION_NAME=us-east-1  # or your region
   S3_ENDPOINT_URL=https://s3.amazonaws.com  # or your endpoint
   ```

   **Optional (AI API Keys):**
   ```
   OPENAI_API_KEY=your-openai-key
   ANTHROPIC_API_KEY=your-anthropic-key
   GOOGLE_API_KEY=your-google-key
   ```

5. **Review and Deploy**
   - Review the configuration
   - Click "Create Resources"
   - Wait for deployment to complete (5-10 minutes)

### 4. Post-Deployment Setup

1. **Access Your App**
   - Your app will be available at: `https://your-app-name.ondigitalocean.app`

2. **Create Admin User**
   - Visit your app URL
   - Sign up for the first account (this becomes the admin)

3. **Configure Settings**
   - Go to Admin Panel → Settings
   - Configure AI providers, models, etc.

## Configuration Details

### Database
- The configuration includes a managed PostgreSQL database
- Database migrations run automatically on startup
- Connection string is provided via `DATABASE_URL` environment variable

### File Storage
- Configure S3-compatible storage for file uploads
- Local storage is not persistent in App Platform
- Files are temporarily stored locally then uploaded to S3

### Scaling
- Starts with 1 instance (basic-xxs)
- Can be scaled up in the DigitalOcean dashboard
- Consider upgrading instance size for better performance

## Troubleshooting

### Build Failures
1. Check the build logs in DigitalOcean dashboard
2. Ensure all dependencies are in `backend/requirements.txt`
3. Verify Node.js version compatibility

### Runtime Issues
1. Check application logs in DigitalOcean dashboard
2. Verify environment variables are set correctly
3. Ensure database is accessible

### Storage Issues
1. Verify S3 credentials and permissions
2. Check bucket name and region settings
3. Ensure CORS is configured for your bucket

## Cost Optimization

### Starter Setup (~$12/month)
- App: basic-xxs ($5/month)
- Database: dev database ($7/month)

### Production Setup (~$25-50/month)
- App: basic-xs or basic-s ($12-24/month)
- Database: basic database ($15/month)
- Spaces: $5/month (250GB)

## Security Considerations

1. **Environment Variables**: Store sensitive data as secrets
2. **CORS**: Configure proper CORS origins for production
3. **HTTPS**: Enabled by default on App Platform
4. **Database**: Use strong passwords and enable SSL
5. **Storage**: Configure proper bucket policies

## Updates and Maintenance

- Updates deploy automatically when you push to your main branch
- Monitor application health via DigitalOcean dashboard
- Set up alerts for deployment failures and high resource usage
- Regular database backups are handled automatically

## Free Deployment Alternatives

If you're looking for free hosting options, here are some recommendations:

### 1. Railway (Recommended for Free Tier)
- **Free Tier**: $5 credit per month (enough for small apps)
- **Pros**: Great Python support, PostgreSQL included, easy deployment
- **Cons**: Limited to $5/month usage

**Setup:**
1. Go to [railway.app](https://railway.app)
2. Connect your GitHub repository
3. Add PostgreSQL service
4. Set environment variables
5. Deploy automatically

### 2. Render (Good Free Option)
- **Free Tier**: Web service sleeps after 15 minutes of inactivity
- **Pros**: PostgreSQL free tier, automatic SSL, Git-based deployment
- **Cons**: Cold starts, limited resources

**Setup:**
1. Go to [render.com](https://render.com)
2. Create web service from GitHub repo
3. Add PostgreSQL database (free tier)
4. Configure environment variables

### 3. Fly.io (Generous Free Tier)
- **Free Tier**: 3 shared-cpu VMs, 3GB storage
- **Pros**: Great performance, Docker support, global deployment
- **Cons**: Requires Docker configuration

### 4. Vercel + PlanetScale (Frontend + Database)
- **Limitation**: Backend would need significant modification for serverless
- **Better for**: Frontend-only deployment with external API

### 5. Supabase + Netlify (Alternative Stack)
- **Approach**: Use Supabase for backend services, Netlify for frontend
- **Pros**: Both have generous free tiers
- **Cons**: Requires application restructuring

## Recommended Free Deployment: Railway

For your OpenUI application, **Railway** is the best free option because:

1. **Easy Setup**: Works with your existing configuration
2. **PostgreSQL Included**: Free PostgreSQL database
3. **Python Support**: Native Python/FastAPI support
4. **$5 Monthly Credit**: Usually enough for development/testing

### Railway Deployment Steps:

1. **Sign up at [railway.app](https://railway.app)**
2. **Create new project from GitHub**
3. **Add PostgreSQL service**
4. **Configure environment variables:**
   ```
   WEBUI_SECRET_KEY=your-secret-key
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   STORAGE_PROVIDER=local  # or configure free S3 alternative
   ```
5. **Deploy automatically**

### Free Storage Options:

Since most free hosting has limitations on file storage, consider:

1. **Cloudflare R2**: 10GB free per month
2. **Backblaze B2**: 10GB free
3. **Google Cloud Storage**: $300 credit for new accounts
4. **Local Storage**: For testing only (files lost on restart)

## Support

If you encounter issues:
1. Check DigitalOcean App Platform documentation
2. Review application logs
3. Open an issue in your repository
4. Contact DigitalOcean support for platform-specific issues

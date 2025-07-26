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

## Support

If you encounter issues:
1. Check DigitalOcean App Platform documentation
2. Review application logs
3. Open an issue in your repository
4. Contact DigitalOcean support for platform-specific issues

# Quick Start Guide - PostgreSQL + Railway

## 🚀 Quick Deployment to Railway

### Step 1: Prepare Your Environment

```bash
# Clone and setup locally first
git clone <your-repo-url>
cd NETAD-FINALS-main

# Create .env from example
cp .env.example .env
```

### Step 2: Local Testing (Optional but Recommended)

**Using Docker:**
```bash
docker-compose up -d
```

**Using existing PostgreSQL:**
```bash
# Update .env with your local database URL
DATABASE_URL=postgresql://username:password@localhost:5432/netad_db

python app.py
```

### Step 3: Deploy to Railway

#### 3.1 Connect GitHub to Railway
1. Go to [railway.app](https://railway.app)
2. Click **New Project** → **Deploy from GitHub repo**
3. Authorize and select this repository

#### 3.2 Configure Services

**Step A: Add PostgreSQL**
1. Click **+ Add Service** → **Database** → **PostgreSQL**
2. Railway creates it automatically

**Step B: Configure Flask App Variables**

Go to **Your App** → **Variables** tab and set:

```
DATABASE_URL=  [Leave empty - Railway adds this automatically from PostgreSQL service]
FLASK_ENV=production
SECRET_KEY=[Generate: python -c "import secrets; print(secrets.token_hex(32))"]
ADMIN_USERNAME=admin
ADMIN_PASSWORD=[Your strong password]
SESSION_COOKIE_SECURE=True
CAMERA_MODE=public
IP_RATE_LIMIT=10 per minute
```

**Step C: Link PostgreSQL to App**

1. Go to **PostgreSQL** service
2. Click **Connect** → Select **Railway Plugin**
3. This auto-sets `DATABASE_URL` ✅

#### 3.3 Deploy

```bash
git push origin main
```

Railway automatically deploys! 🎉

### Step 4: Verify

Check Railway logs:
```
Your App → Logs → Watch for "Initializing database..."
```

## 📊 Database Schema

Your PostgreSQL database includes:

| Table | Purpose |
|-------|---------|
| `users` | User accounts (admin/user roles) |
| `logs` | Activity logs |
| `allowed_ips` | Whitelisted IPs |
| `blocked_ips` | Blacklisted IPs |
| `login_requests` | Pending IP approvals |
| `notifications` | System notifications |
| `system_settings` | Config values |

## 🔐 Admin Credentials

- **Username**: `admin` (from `ADMIN_USERNAME`)
- **Password**: Your `ADMIN_PASSWORD` environment variable

The admin user is automatically created on first run.

## 🛠 Troubleshooting

### Issue: App won't start in Railway

**Check logs** for:
- `DATABASE_URL not found` → Add PostgreSQL service and link it
- `psycopg not installed` → Already in `requirements.txt` ✅
- Permission denied → Check database credentials

### Issue: Can't login after deploy

1. Check admin credentials in Railway variables
2. Clear browser cookies and try again
3. Check app logs for authentication errors

### Issue: Database not initialized

The app auto-creates tables on startup. If it doesn't:

```bash
# SSH into Railway app and run:
python -c "from db import init_db; init_db()"
```

## 📝 Environment Variables Reference

| Variable | Example | Notes |
|----------|---------|-------|
| `DATABASE_URL` | `postgresql://...` | Auto-set by Railway PostgreSQL |
| `FLASK_ENV` | `production` | Required for Railway |
| `SECRET_KEY` | Random 64-char hex | **Must change from default** |
| `ADMIN_USERNAME` | `admin` | First user created on startup |
| `ADMIN_PASSWORD` | `Strong@Pass123` | **Use strong password** |
| `SESSION_COOKIE_SECURE` | `True` | Enable in production |
| `CAMERA_MODE` | `public` or `local` | Camera source type |
| `IP_RATE_LIMIT` | `10 per minute` | Brute-force protection |

## 🔄 Backup & Restore

### Export data from Railway PostgreSQL:

```bash
# Install Railway CLI
npm install -g @railway/cli

# Backup
railway run pg_dump > backup.sql

# Restore
railway run psql < backup.sql
```

## ✅ Ready to Deploy!

Your app is production-ready with:
- ✅ PostgreSQL support (psycopg3)
- ✅ Automatic table creation
- ✅ Environment variable configuration
- ✅ Docker setup for local testing
- ✅ Railway deployment files

**Next step:** Push to GitHub and watch Railway auto-deploy! 🚀

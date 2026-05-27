# PostgreSQL Setup Guide - NETAD Finals

Complete guide to set up PostgreSQL database for local development and Railway deployment.

---

## 📌 Table of Contents

1. [Local Development Setup](#local-development-setup)
2. [Railway Deployment](#railway-deployment)
3. [GitHub Actions](#github-actions)
4. [Database Tables](#database-tables)
5. [Environment Variables](#environment-variables)

---

## Local Development Setup

### Option 1: Using Docker (Recommended)

#### 1.1 Prerequisites
- Docker and Docker Compose installed
- [Download Docker](https://www.docker.com/products/docker-desktop)

#### 1.2 Start PostgreSQL Container

Create `docker-compose.yml` in the project root:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: netad_postgres
    environment:
      POSTGRES_DB: netad_db
      POSTGRES_USER: netad_user
      POSTGRES_PASSWORD: netad_password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U netad_user"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

#### 1.3 Start the Database

```bash
docker-compose up -d
```

#### 1.4 Update `.env` File

```env
DATABASE_URL=postgresql://netad_user:netad_password@localhost:5432/netad_db
FLASK_ENV=development
SECRET_KEY=your-dev-secret-key-change-before-production
ADMIN_USERNAME=admin
ADMIN_PASSWORD=Admin@12345
```

#### 1.5 Initialize Database

```bash
python -m pip install psycopg[binary]
python app.py
```

The app will automatically create all tables on startup.

---

### Option 2: Manual PostgreSQL Installation

#### 2.1 Install PostgreSQL
- **Windows**: [Download PostgreSQL](https://www.postgresql.org/download/windows/)
- **Mac**: `brew install postgresql@15`
- **Linux**: `sudo apt-get install postgresql postgresql-contrib`

#### 2.2 Create Database and User

```bash
# Connect to PostgreSQL
psql -U postgres

# In psql prompt:
CREATE DATABASE netad_db;
CREATE USER netad_user WITH PASSWORD 'netad_password';
GRANT ALL PRIVILEGES ON DATABASE netad_db TO netad_user;
```

#### 2.3 Create Tables

```bash
psql -U netad_user -d netad_db -f postgres_schema.sql
```

#### 2.4 Update `.env` File

```env
DATABASE_URL=postgresql://netad_user:netad_password@localhost:5432/netad_db
```

---

## Railway Deployment

### Step 1: Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Click **New Project** → **Provision PostgreSQL**
3. Wait for PostgreSQL to be created

### Step 2: Get Database URL from Railway

1. Click on **PostgreSQL** service
2. Go to **Connect** tab
3. Copy the PostgreSQL connection string (looks like: `postgresql://user:password@host:port/dbname`)

### Step 3: Set Environment Variables in Railway

1. Go to your Flask app service in Railway
2. Click **Variables** tab
3. Add these environment variables:

```
DATABASE_URL=postgresql://[copy from step 2]
FLASK_ENV=production
SECRET_KEY=[generate a strong random key]
ADMIN_USERNAME=admin
ADMIN_PASSWORD=[strong password - change this!]
SESSION_COOKIE_SECURE=True
```

### Step 4: Deploy

```bash
git push
```

Railway will automatically:
- Install dependencies from `requirements.txt`
- Run `python app.py`
- Create all database tables automatically

### Step 5: Verify Database Connection

Check Railway logs:
```
[Railway Dashboard] → [Flask App] → [Logs]
```

You should see:
```
INFO: Initializing database...
INFO: Creating tables...
```

---

## GitHub Actions

### Set Up GitHub Secrets

1. Go to **GitHub Repository** → **Settings** → **Secrets and variables** → **Actions**
2. Add these secrets:

```
DATABASE_URL_STAGING=postgresql://...
DATABASE_URL_PRODUCTION=postgresql://...
ADMIN_PASSWORD=your_secure_password
FLASK_ENV=production
SECRET_KEY=your_secure_key
```

### Create Workflow File

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Railway

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy to Railway
        run: |
          npm i -g @railway/cli
          railway up
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
          DATABASE_URL: ${{ secrets.DATABASE_URL_PRODUCTION }}
```

---

## Database Tables

### users
```sql
id (SERIAL PRIMARY KEY)
username (TEXT UNIQUE NOT NULL)
password_hash (TEXT NOT NULL)
role (TEXT DEFAULT 'user')
approved (BOOLEAN DEFAULT false)
created_at (TIMESTAMPTZ DEFAULT NOW())
```

### logs
```sql
id (SERIAL PRIMARY KEY)
user_id (INTEGER)
username (TEXT)
ip (TEXT)
event (TEXT NOT NULL)
category (TEXT NOT NULL)
success (BOOLEAN DEFAULT false)
created_at (TIMESTAMPTZ DEFAULT NOW())
```

### allowed_ips
```sql
id (SERIAL PRIMARY KEY)
ip (TEXT UNIQUE NOT NULL)
label (TEXT)
active (BOOLEAN DEFAULT true)
approved_by (TEXT)
approved_at (TIMESTAMPTZ DEFAULT NOW())
created_at (TIMESTAMPTZ DEFAULT NOW())
```

### blocked_ips
```sql
id (SERIAL PRIMARY KEY)
ip (TEXT UNIQUE NOT NULL)
reason (TEXT)
active (BOOLEAN DEFAULT true)
blocked_by (TEXT)
blocked_at (TIMESTAMPTZ DEFAULT NOW())
```

### login_requests
```sql
id (SERIAL PRIMARY KEY)
username (TEXT)
ip (TEXT NOT NULL)
device_info (TEXT)
status (TEXT DEFAULT 'pending')
admin_notes (TEXT)
created_at (TIMESTAMPTZ DEFAULT NOW())
updated_at (TIMESTAMPTZ DEFAULT NOW())
```

### notifications
```sql
id (SERIAL PRIMARY KEY)
title (TEXT NOT NULL)
message (TEXT NOT NULL)
level (TEXT DEFAULT 'info')
target_role (TEXT DEFAULT 'admin')
is_read (BOOLEAN DEFAULT false)
created_at (TIMESTAMPTZ DEFAULT NOW())
```

### system_settings
```sql
key (TEXT PRIMARY KEY)
value (TEXT)
```

---

## Environment Variables

### Local Development (`.env`)

```env
# Flask Configuration
FLASK_ENV=development
SECRET_KEY=dev-secret-key-change-before-production

# Database
DATABASE_URL=postgresql://netad_user:netad_password@localhost:5432/netad_db

# Admin Credentials
ADMIN_USERNAME=admin
ADMIN_PASSWORD=Admin@12345

# Camera Configuration
CAMERA_MODE=public
LOCAL_CAMERA_INDEX=0
PUBLIC_CAMERA_URL=

# Security Settings
SESSION_COOKIE_SECURE=False
IP_RATE_LIMIT=15 per minute
```

### Production (Railway Environment Variables)

```env
FLASK_ENV=production
SECRET_KEY=<generate-secure-key>
DATABASE_URL=postgresql://... (from Railway PostgreSQL)
ADMIN_USERNAME=admin
ADMIN_PASSWORD=<strong-password>
SESSION_COOKIE_SECURE=True
IP_RATE_LIMIT=10 per minute
```

---

## Testing the Connection

### Local Test

```bash
python3 << EOF
import os
from db import get_db_connection, is_postgres

print(f"Using PostgreSQL: {is_postgres()}")

try:
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT version();")
    version = cursor.fetchone()
    print(f"✅ Connected to PostgreSQL: {version}")
    conn.close()
except Exception as e:
    print(f"❌ Connection failed: {e}")
EOF
```

### Railway Test

Check logs in Railway dashboard:
1. Go to your Flask app
2. Click **Logs** tab
3. Search for "Initializing database" message

---

## Troubleshooting

### Issue: "psycopg not installed"
```bash
pip install psycopg[binary]
```

### Issue: Connection refused
- Verify `DATABASE_URL` is correct
- Check PostgreSQL is running
- For Docker: `docker-compose ps`

### Issue: Database not created
```bash
python app.py  # This auto-creates tables
```

### Issue: Tables already exist
The app handles this safely with `CREATE TABLE IF NOT EXISTS`

---

## Backup Database (Railway)

### Using Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Backup
railway run pg_dump > backup.sql

# Restore
railway run psql < backup.sql
```

---

## Performance Notes

- Added indexes on frequently queried columns (ip, user_id, created_at)
- Use `TIMESTAMPTZ` for timezone-aware timestamps
- Connection pooling handled by psycopg automatically

---

**Ready to deploy! 🚀**

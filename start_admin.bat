# NETAD Finals - Networking Administration System

A Flask-based networking administration system with camera management, IP whitelisting, and user authentication.

## 📋 Project Features

- **User Authentication**: Secure login with role-based access control (Admin/User)
- **IP Management**: Whitelist/blacklist IP addresses, track login requests
- **Camera Management**: Support for local and public camera feeds
- **Activity Logging**: Comprehensive logging of all system activities
- **Security**: Rate limiting, brute-force protection, session management
- **Dashboard**: Real-time metrics and system overview

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Setup Environment Variables

The `.env` file already contains default credentials for testing:

```env
ADMIN_USERNAME=admin
ADMIN_PASSWORD=Admin@12345
FLASK_ENV=production
SECRET_KEY=your-secret-key-change-this-in-production
```

**Important**: Change `SECRET_KEY` and credentials before deploying to production!

### 3. Initialize Database and Admin User

```bash
python setup.py
```

This will:
- Create the SQLite database
- Initialize all tables
- Create the admin user with credentials from `.env`

### 4. Run the Application

```bash
python app.py
```

The app will start on `http://localhost:5000`

### 5. Login

Use the credentials from `.env`:
- **Username**: admin
- **Password**: Admin@12345

---

## 📝 Configuration

Edit the `.env` file to customize:

| Variable | Purpose | Default |
|----------|---------|---------|
| `ADMIN_USERNAME` | Admin user login | admin |
| `ADMIN_PASSWORD` | Admin password | Admin@12345 |
| `CAMERA_MODE` | local or public | public |
| `PUBLIC_CAMERA_URL` | External camera URL | (empty) |
| `SESSION_COOKIE_SECURE` | HTTPS only cookies | False |
| `IP_RATE_LIMIT` | Rate limiting rule | 15 per minute |
| `SECRET_KEY` | Flask secret key | (generated) |

---

## 🗄️ Database

- **Local**: SQLite (`database.db`)
- **Production**: PostgreSQL (set `DATABASE_URL` in `.env`)

### Reset Database

```bash
rm database.db
python setup.py
```

---

## 🔐 For Railway Deployment

1. Set these environment variables in Railway:
   - `SECRET_KEY` (generate with: `python -c "import secrets; print(secrets.token_hex(32))"`)
   - `ADMIN_USERNAME` 
   - `ADMIN_PASSWORD`
   - `DATABASE_URL` (Railway PostgreSQL plugin)
   - `SESSION_COOKIE_SECURE=true`
   - `FLASK_ENV=production`

2. Connect Railway PostgreSQL plugin
3. Deploy!

---

## 📂 Project Structure

```
.
├── app.py              # Main Flask application
├── auth.py             # Authentication blueprint
├── models.py           # Database models and queries
├── config.py           # Configuration management
├── db.py               # Database initialization
├── security.py         # Security utilities
├── camera.py           # Camera stream handling
├── requirements.txt    # Python dependencies
├── Dockerfile          # Docker configuration
├── Procfile            # Procfile for deployment
├── setup.py            # Setup script
├── .env                # Environment variables
└── templates/          # HTML templates
    ├── base.html
    ├── dashboard.html
    ├── login.html
    ├── admin_requests.html
    └── ...
```

---

## 🛠️ Troubleshooting

### Can't log in?
- Ensure database is initialized: `python setup.py`
- Check `.env` file has `ADMIN_USERNAME` and `ADMIN_PASSWORD`
- Reset database: `rm database.db && python setup.py`

### Database errors?
- Make sure PostgreSQL is running (if using `DATABASE_URL`)
- For SQLite: ensure `database.db` file is writable

### Camera not working?
- Set `CAMERA_MODE=public` and provide `PUBLIC_CAMERA_URL` in `.env`
- Or use `CAMERA_MODE=local` with `LOCAL_CAMERA_INDEX=0`

---

## 📚 Additional Commands

```bash
# Run with debug mode (development only)
FLASK_ENV=development python app.py

# Using gunicorn (production)
gunicorn app:app --bind 0.0.0.0:8080 --workers=2

# Using Docker
docker build -t netad .
docker run -p 8080:8080 --env-file .env netad
```

---

## ✅ Ready for Submission

Your system is configured with:
- ✅ Default admin credentials (admin / Admin@12345)
- ✅ Database initialization script
- ✅ Environment variable support
- ✅ Railway deployment ready
- ✅ Security best practices
- ✅ Comprehensive logging

Good luck with your networking administration finals! 🎓

---

**Last Updated**: May 2026

# NETAD Administrator Setup & Permissions Guide

## 🎯 Quick Start - Become System Administrator

### Step 1: Run Admin Setup Script

```bash
# Windows
python admin_setup.py

# Linux/Mac
python3 admin_setup.py
```

This will:
- ✅ Verify database connection
- ✅ Check all required tables
- ✅ Create/verify admin user
- ✅ Whitelist localhost
- ✅ Display login credentials

### Step 2: Start the Application

```bash
python app.py
```

### Step 3: Login as Administrator

**Go to:** http://127.0.0.1:5000/auth/login

**Credentials:**
```
Username: admin
Password: Admin@12345
```

---

## 🔐 Admin Permissions & Control

As system administrator, you have full control over:

### User Management
- ✅ Create new user accounts
- ✅ Approve/deny user requests
- ✅ Manage user roles (admin/user)
- ✅ View all users

### IP Management
- ✅ Whitelist IP addresses (allow access)
- ✅ Blacklist IP addresses (block access)
- ✅ Review pending approval requests
- ✅ Manage IP policies

### System Monitoring
- ✅ View all activity logs
- ✅ Monitor login attempts
- ✅ Track security events
- ✅ Access dashboard analytics

### Camera Management
- ✅ Configure camera modes (local/public)
- ✅ Manage camera feeds
- ✅ View CCTV monitoring

### Configuration
- ✅ Update system settings
- ✅ Configure security policies
- ✅ Send notifications
- ✅ Manage rate limiting

---

## 📊 Administrator Features

### Dashboard
Location: http://127.0.0.1:5000/dashboard

Shows:
- Active users count
- Blocked IPs count
- Pending approvals
- Recent activity
- Unread alerts

### Admin Panel
Location: http://127.0.0.1:5000/admin

Controls:
- **User Management** - Create, approve, delete users
- **IP Management** - Whitelist/blacklist IPs
- **Logs** - View all system activity
- **Notifications** - Send system alerts
- **Settings** - Configure system options

### Login Requests
Location: http://127.0.0.1:5000/admin_requests

Review and approve:
- New IP access requests
- Pending user applications
- Security alerts

### IP Management
Location: http://127.0.0.1:5000/ip_management

Manage:
- Allowed IP list (whitelist)
- Blocked IP list (blacklist)
- IP approval history

---

## 🔧 Troubleshooting

### Issue: Can't login as admin

**Solution 1: Run admin setup**
```bash
python admin_setup.py
```

**Solution 2: Reset admin account**
```bash
python admin_reset.py
```

### Issue: Database connection failed

**Check .env file:**
```env
DATABASE_URL=postgresql://user:password@host:port/dbname
```

**For local development:**
```env
DATABASE_URL=  # Leave empty for SQLite
```

### Issue: "Administrator access required" error

**Solution:**
1. Logout (click Logout button)
2. Clear browser cookies
3. Login again with admin account
4. Check that your IP is whitelisted

---

## 🚀 Advanced Administration

### Reset Password

As admin in browser:
1. Go to Admin Panel
2. User Management
3. Find user
4. Click "Reset Password"

### Export Logs

As admin:
1. Go to Logs page
2. Click "Export" button
3. Choose format (CSV, JSON, PDF)

### Backup Database

For PostgreSQL (Railway):
```bash
# Backup
railway run pg_dump > backup.sql

# Restore
railway run psql < backup.sql
```

For SQLite:
```bash
# Simple copy
cp database.db database.db.backup
```

---

## 🛡️ Security Best Practices

1. **Change Default Password**
   - Login as admin
   - Go to Settings → Change Password
   - Use a strong password (16+ characters)

2. **Change SECRET_KEY**
   - Update in .env file
   - Restart application

3. **Enable HTTPS**
   - Set `SESSION_COOKIE_SECURE=True` for production
   - Deploy with HTTPS certificate

4. **Regular Backups**
   - Backup database daily
   - Keep offline copies

5. **Review Logs**
   - Check activity logs regularly
   - Monitor failed login attempts

6. **IP Whitelist Policy**
   - Only approve known IPs
   - Regularly audit allowed IPs
   - Remove unused IPs

---

## 📋 Environment Variables (Admin)

```env
# Admin Account
ADMIN_USERNAME=admin                    # Your admin username
ADMIN_PASSWORD=Admin@12345              # Your admin password

# Database
DATABASE_URL=postgresql://...           # PostgreSQL URL (Railway)
DATABASE_URL=                           # Empty for SQLite (local dev)

# Security
SECRET_KEY=your-secret-key-here        # Change before production!
SESSION_COOKIE_SECURE=False            # True for production HTTPS
IP_RATE_LIMIT=15 per minute            # Brute force protection

# Application
FLASK_ENV=production                    # production or development
CAMERA_MODE=public                      # public or local
```

---

## ✨ Admin Account Features

### Role: **ADMIN**
- ✓ Full system access
- ✓ User management
- ✓ IP management
- ✓ Log viewing
- ✓ System configuration
- ✓ Notification sending

### Status: **APPROVED**
- ✓ No IP whitelist required
- ✓ Immediate login access
- ✓ Full dashboard access

### Permissions: **COMPLETE**
- ✓ Read all data
- ✓ Write/modify data
- ✓ Delete accounts
- ✓ Configure system
- ✓ Manage policies

---

## 🎓 Next Steps

1. **Setup Admin Account**
   ```bash
   python admin_setup.py
   ```

2. **Start Application**
   ```bash
   python app.py
   ```

3. **Login to Dashboard**
   ```
   http://127.0.0.1:5000/auth/login
   Username: admin
   Password: Admin@12345
   ```

4. **Change Default Password** ⚠️
   - Go to Settings → Change Password
   - Use a strong, unique password

5. **Configure System**
   - Set up IP policies
   - Configure camera settings
   - Customize notifications

---

**You now have complete administrative control over the NETAD system! 🎉**

# 🚀 RAILWAY DEPLOYMENT GUIDE FOR AKSHIVA BOT

## 📋 PREREQUISITES CHECKLIST

Before deploying to Railway, ensure you have:

- [x] GitHub account (to fork/push your code)
- [x] Railway account (sign up at railway.app)
- [x] Telegram Bot Token (from @BotFather)
- [x] Telegram API ID & Hash (from my.telegram.org)
- [x] MongoDB Atlas connection string (free tier available)
- [x] Admin & Channel IDs configured
- [x] Git installed locally

---

## 🔧 STEP 1: PREPARE YOUR REPOSITORY

### Option A: Using GitHub (Recommended)

```bash
# Clone/fork this repository
git clone <your-repo-url>
cd akshiva-main

# Add remote if not already there
git remote add origin <your-github-repo-url>

# Commit changes
git add .
git commit -m "Add Railway deployment files"
git push -u origin main
```

### Option B: Initialize Git (if new repo)

```bash
git init
git add .
git commit -m "Initial Akshiva Bot commit"
git remote add origin <your-github-repo-url>
git push -u origin main
```

---

## 🚢 STEP 2: CONNECT RAILWAY

### 2A. Create Railway Project

1. Go to **https://railway.app**
2. Click **"New Project"**
3. Select **"Deploy from GitHub"**
4. Authorize Railway to access your GitHub
5. Select your **akshiva-main** repository
6. Click **Deploy**

### 2B. Alternative: Using Railway CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Create project in current directory
railway init

# Link to your Git repo (when prompted)
```

---

## 🔐 STEP 3: SET ENVIRONMENT VARIABLES

### Critical Variables (Must Set)

In **Railway Dashboard** → **Project** → **Variables** tab:

#### Telegram Credentials
```
API_ID = <Your API ID from my.telegram.org>
API_HASH = <Your API Hash from my.telegram.org>
BOT_TOKEN = <Your bot token from @BotFather>
```

#### Database
```
DATABASE_URI = mongodb+srv://<user>:<password>@<cluster>.mongodb.net/?retryWrites=true&w=majority
DATABASE_URI2 = <Backup MongoDB URI if available>
DATABASE_NAME = cluster_0
COLLECTION_NAME = mtqlfehk
```

#### Admin & Channels (space-separated)
```
ADMINS = 6093349648 <other-admin-ids>
CHANNELS = -1001952883830 -1001931435328 <other-channel-ids>
SUPPORT_GROUP = -1002400409881
LOG_CHANNEL = -1002122516919
AUTH_CHANNEL = -1002329006749
DELETE_CHANNELS = -1002122516919
MOVIE_UPDATE = -1002122516919
LOG_VR_CHANNEL = -1002484794506
LOG_API_CHANNEL = -1002122516919
MOVIE_UPDATE_CHANNEL = -1002122516919
PREMIUM_LOGS = -1002122516919
REQ_CHANNEL = -1002122516919
BIN_CHANNEL = -1002554117358
```

#### API Keys & Services
```
SHORTENER_API = f8d1f9d825ea1132bf073ca6f5357b81ea5bc918
SHORTENER_API2 = f8d1f9d825ea1132bf073ca6f5357b81ea5bc918
SHORTENER_WEBSITE = aroLinks.com
SHORTENER_WEBSITE2 = arolinks.com
STREAM_API = b53e4769ab3cc30124a32cb9c27496c7ddaddecc
STREAM_SITE = gplinks.com
```

#### Configuration
```
PORT = 8004
FILE_AUTO_DEL_TIMER = 600
DELETE_TIME = 300
TWO_VERIFY_GAP = 43200
REFERAL_COUNT = 15
REFERAL_PREMEIUM_TIME = 7day
MAX_BTN = 8
SKIP = 2
```

#### Custom Links & Media
```
USERNAME = https://t.me/DG_shiva
MOVIE_GROUP_LINK = https://t.me/movies_group8
GRP_LNK = https://t.me/movies_group8
TUTORIAL = t.me/moviehiap/9
TUTORIAL_2 = https://t.me/moviehiap/9
STREAMHTO = https://t.me/
URL = http://dragon-stream.codeltix.com
START_IMG = https://envs.sh/bNy.jpg
MONEY_IMG = https://graph.org/file/f53094fbcccead10fb6e7.jpg
VERIFY_IMG = https://graph.org/file/1669ab9af68eaa62c3ca4.jpg
WELCOME_VID = https://telegra.ph/file/451f038b4e7c2ddd10dc0.mp4
QR_CODE = https://i.ibb.co/Swrgp0ts/file-426.jpg.jpg
QR = https://i.ibb.co/Swrgp0ts/file-426.jpg.jpg
REFER_PICS = https://graph.org/file/1a2e64aee3d4d10edd930.jpg
```

---

## ✅ STEP 4: DEPLOYMENT CONFIGURATION OPTIONS

### Option 1: Using Dockerfile (Recommended for this bot)

Railway will automatically detect and use **Dockerfile** if present.

**Advantages**:
- ✅ Full control over dependencies
- ✅ FFmpeg guaranteed to work
- ✅ Custom system packages
- ✅ Better performance

**What it does**:
1. Uses Python 3.10 slim image
2. Installs FFmpeg, OpenSSL, libffi
3. Installs all Python dependencies
4. Runs `python3 bot.py`

### Option 2: Using Heroku Buildpacks

Edit `railway.json`:
```json
{
  "build": {
    "builder": "heroku.buildpacks"
  }
}
```

**Advantages**:
- Automatic dependency detection
- Auto-scaling based on load

### Option 3: Using railway.toml

Create/edit `railway.toml` with detailed configuration.

---

## 🎯 STEP 5: MONITOR DEPLOYMENT

### In Railway Dashboard:

1. **Deployments Tab**: Watch build progress
2. **Logs Tab**: Check for errors in real-time
3. **Status**: Green = Running, Yellow = Building, Red = Error

### Expected First-Run Logs:
```
av_botz_update is started now ❤️
Bot restarted at [TIME]
[Bot name] restarted 😚
✅ Bot restarted
```

### Troubleshoot Common Issues:

| Issue | Solution |
|-------|----------|
| `ModuleNotFoundError` | Ensure all requirements are in `requirements.txt` |
| `FFmpeg not found` | Dockerfile is being used and has FFmpeg installation |
| `MongoDB connection failed` | Verify DATABASE_URI is correct and IP whitelist on MongoDB Atlas |
| `Bot not responding` | Check LOG_CHANNEL for startup messages, verify BOT_TOKEN |
| `Port already in use` | Railway handles this, but check for port conflicts in code |

---

## 📊 STEP 6: PERFORMANCE OPTIMIZATION FOR RAILWAY

### Worker Configuration

Edit **bot.py** line 25:
```python
# Current (high resource usage)
workers=150,

# For Railway Free Tier (recommended)
workers=50,

# For Railway Pro Plan
workers=100,
```

### Connection Pool Size

In **database files**, adjust:
```python
# Add to AsyncIOMotorClient initialization
maxPoolSize=20,  # Default is 50, reduce for Railway
minPoolSize=5,
```

### Memory Management

Set Python memory hints:
```bash
# In Railway environment
PYTHONUNBUFFERED=1
PYTHONOPTIMIZE=2
```

---

## 🔄 STEP 7: DEPLOYMENT & SCALING

### View Deployment Status
```bash
railway status
```

### Redeploy (after git push)
Railway auto-deploys on push. To manually trigger:
1. Go to Railway Dashboard
2. Click **Deployments**
3. Click **Deploy**

### Scale Resources (Pro Plan)

In Railway Dashboard → **Settings** → **Resource Options**:
- Memory: 512MB (minimum for this bot)
- CPU: 0.5 vCPU (minimum)

For better performance:
- Memory: 1GB+
- CPU: 1 vCPU

---

## 🛡️ STEP 8: DATABASE SETUP (MongoDB Atlas)

### If using MongoDB Atlas (Free Tier):

1. Go to **mongodb.com/cloud**
2. Create free account
3. Click **Build a Cluster**
4. Choose free tier
5. Create cluster (takes ~3 minutes)
6. Click **Connect**
7. Copy connection string: `mongodb+srv://user:pass@cluster.mongodb.net/`
8. Update DATABASE_URI in Railway variables

### Allow IP Access:
1. Go to **MongoDB Atlas Dashboard**
2. **Network Access**
3. **Add IP Address**
4. Click **Allow Access from Anywhere** (0.0.0.0/0)
   - ⚠️ Only for testing! For production, whitelist Railway IP

---

## 📱 STEP 9: TESTING THE BOT

After deployment completes:

```bash
# In Telegram
/start          # Should show welcome message
/help           # Should show commands
/plan           # Should show premium plans
```

### Check Logs
1. Go to Railway Dashboard
2. Click **Logs** tab
3. Look for "Bot started" message

### Verify Web Server
Visit: `https://<your-railway-app-url>.railway.app/`
Should return JSON response from route.py

---

## 🔄 CONTINUOUS DEPLOYMENT

### Auto-Deploy on Push

Railway automatically redeploys when you push to main branch:

```bash
# Make changes locally
git add .
git commit -m "Update bot features"
git push origin main

# Railway automatically detects and deploys!
# Check status in dashboard
```

### Disable Auto-Deploy
Railway Dashboard → **Settings** → Uncheck **Auto-deploy**

---

## 🚨 IMPORTANT WARNINGS

⚠️ **DO NOT:**
- ❌ Commit `.env` files or secrets to git
- ❌ Use DATABASE_URI in bot.py (only in environment)
- ❌ Set workers > 100 for free tier (memory issues)
- ❌ Hardcode Telegram credentials anywhere

✅ **ALWAYS:**
- ✅ Use Railway environment variables
- ✅ Keep bot.py clean of credentials
- ✅ Test locally before pushing
- ✅ Monitor logs for errors

---

## 📞 SUPPORT RESOURCES

- Railway Docs: https://docs.railway.app
- Pyrogram Docs: https://docs.pyrogram.org
- MongoDB Atlas: https://docs.atlas.mongodb.com
- Telegram Bot API: https://core.telegram.org/bots

---

## ✨ FINAL CHECKLIST

- [x] Repository created and pushed to GitHub
- [x] Railway project connected
- [x] All environment variables set
- [x] MongoDB Atlas cluster created
- [x] Dockerfile/railway.json configured
- [x] First deployment successful
- [x] Bot responding in Telegram
- [x] Logs showing no errors
- [x] Premium features working
- [x] Broadcasting working
- [x] IMDB integration working

---

## 🎉 DEPLOYMENT COMPLETE!

Your Akshiva Bot is now **live on Railway** and ready to serve!

For more help:
- Check logs regularly
- Monitor memory/CPU usage
- Keep dependencies updated
- Backup MongoDB regularly

**Happy Botting! 🤖🚀**

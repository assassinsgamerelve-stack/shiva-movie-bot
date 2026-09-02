# ⚡ RAILWAY QUICK START - 5 MINUTES TO LIVE BOT

## 🎯 TL;DR (Super Quick)

```bash
# 1. Push to GitHub
git push origin main

# 2. Create Railway project and link GitHub repo
# 3. Add all variables from railway-env-template.txt
# 4. Click Deploy
# 5. Check logs and bot should be LIVE! ✅
```

---

## 📦 FILES INCLUDED FOR RAILWAY

| File | Purpose |
|------|---------|
| **railway.json** | Railway configuration (auto-detected) |
| **Dockerfile** | Build configuration with FFmpeg |
| **railway.toml** | Alternative TOML configuration |
| **.railwayignore** | Files to exclude from deployment |
| **build.sh** | Pre-deployment setup script |
| **requirements_railway.txt** | Optimized dependencies |
| **railway-env-template.txt** | Environment variables template |
| **RAILWAY_DEPLOYMENT.md** | Full detailed guide (50+ steps) |
| **RAILWAY_QUICK_START.md** | This file |

---

## 🚀 FASTEST DEPLOYMENT PATH

### Step 1: GitHub (1 min)
```bash
cd akshiva-main
git add .
git commit -m "Add Railway files"
git push origin main
```

### Step 2: Railway Dashboard (2 mins)
1. Go to https://railway.app
2. Click "New Project" → "Deploy from GitHub"
3. Select your repository
4. Wait for build to complete

### Step 3: Environment Variables (1 min)
1. Click "Variables" tab
2. Add these CRITICAL ones:
   ```
   API_ID = <your value>
   API_HASH = <your value>
   BOT_TOKEN = <your value>
   DATABASE_URI = <your MongoDB URL>
   ADMINS = <space separated user IDs>
   CHANNELS = <space separated channel IDs>
   SUPPORT_GROUP = <channel ID>
   LOG_CHANNEL = <channel ID>
   ```
3. See `railway-env-template.txt` for all 40+ variables
4. Click Save

### Step 4: Deploy (1 min)
1. Go to "Deployments" tab
2. Click "Deploy"
3. Wait for green checkmark ✅

### Step 5: Verify (30 secs)
1. Go to "Logs" tab
2. Look for: `"Bot name" is started now ❤️`
3. Send `/start` to bot in Telegram
4. Should get welcome message!

---

## 🔑 GETTING REQUIRED CREDENTIALS

### API_ID & API_HASH
- Go to https://my.telegram.org
- Click "API development tools"
- Create app or use existing
- Copy values

### BOT_TOKEN
- Chat @BotFather on Telegram
- Send `/newbot`
- Follow instructions
- Copy token

### DATABASE_URI
- Go to https://mongodb.com/cloud
- Create free cluster
- Click "Connect"
- Choose "Drivers" → Python
- Copy connection string
- Replace `<password>` with your password

### ADMINS / CHANNEL IDs
- Forward any message from admin to @id_echo_bot → copy ID
- Right-click channel → Copy Link → extract ID from URL
- Format as space-separated: `123456789 987654321`

---

## ⚠️ WHAT NOT TO DO

❌ **DON'T:**
- Commit credentials to GitHub
- Use .env files
- Hardcode passwords
- Set workers > 100
- Make DATABASE_URI public

✅ **DO:**
- Use Railway Variables dashboard
- Keep credentials in Railway only
- Test locally first
- Check logs after deploy
- Monitor resource usage

---

## 🔧 DEPLOYMENT OPTIONS EXPLAINED

### Option 1: Dockerfile (RECOMMENDED) ⭐
```
✅ Guaranteed to work
✅ FFmpeg included
✅ Full control
✅ Faster deployment
```
Railway will auto-detect and use `Dockerfile`

### Option 2: railway.json
```
For simple configuration
Alternative to Dockerfile
Uses Heroku buildpacks
```

### Option 3: railway.toml  
```
TOML format configuration
Detailed environment hints
More readable settings
```

---

## 🎯 EXPECTED BEHAVIOR

### On First Deploy:
1. Railway builds Docker image (~2-3 mins)
2. Installs dependencies (~1-2 mins)
3. Starts bot (`python3 bot.py`)
4. Bot connects to MongoDB
5. Bot connects to Telegram
6. Sends startup message to LOG_CHANNEL
7. Bot is LIVE! ✅

### Logs Should Show:
```
Step 1/15 : FROM python:3.10-slim
...
[+] Building image successfully
...
av_botz_update is started now ❤️
Bot restarted ✅
```

---

## 🔍 TROUBLESHOOTING

### ❌ Bot doesn't start
**Check:**
1. Go to Logs → Look for errors
2. Verify BOT_TOKEN is correct
3. Verify DATABASE_URI connection works

### ❌ MongoDB connection fails
**Check:**
1. DATABASE_URI format: `mongodb+srv://user:pass@cluster.mongodb.net/`
2. MongoDB Atlas → Network Access → Allow from anywhere (0.0.0.0/0)
3. User credentials are correct

### ❌ FFmpeg not found error
**Check:**
1. Using Dockerfile (not Heroku buildpacks)
2. Dockerfile exists in root directory
3. Rebuild deployment

### ❌ Port already in use
**Check:**
1. CODE uses port: `PORT = os.environ.get('PORT', '8004')`
2. Railway provides PORT automatically
3. Should not cause issues

### ❌ "Module not found" errors
**Check:**
1. All packages in `requirements.txt`
2. Spelling is correct
3. Rebuild and deploy again

---

## 📊 MONITORING AFTER DEPLOY

### Railway Dashboard:
- **Deployments** → See build history
- **Logs** → Real-time logs
- **Metrics** → CPU, Memory, Network usage
- **Settings** → Resource limits, scales

### Performance Tips:
1. **Memory**: Keep under 400MB (free tier)
2. **Workers**: Set to 50 for free tier
3. **Connections**: MongoDB limit to 20
4. **Files**: Auto-delete old cached IMDB data

---

## 🚀 AFTER DEPLOYMENT

### Test These Features:
```
/start         → Bot welcome message
/help          → Commands list
/plan          → Premium plans
/broadcast     → Admin broadcast
/stats         → Bot statistics
```

### Monitor These:
1. **Bot responsiveness** - Should reply in < 1 second
2. **Memory usage** - Should stay < 300MB
3. **Database queries** - Check logs for errors
4. **Error rate** - Should be near 0%

---

## 🔄 UPDATING BOT

After you make changes:

```bash
# Make changes locally
nano bot.py          # or your editor
git add .
git commit -m "Updated features"
git push origin main

# Railway automatically deploys! ✅
# No manual deploy needed
```

---

## 💡 PERFORMANCE TUNING

For Railway Free Tier (perfect for testing):
```
✅ Works great with:
- 50 concurrent workers
- 20 MongoDB connections
- 600 second file cleanup
- 8 buttons max per message
```

For Railway Pro (better performance):
```
✅ Can handle:
- 100+ concurrent workers
- 50+ MongoDB connections
- Advanced features enabled
- 10+ buttons per message
```

To upgrade:
1. Railway Dashboard → Settings
2. Change Resource Plan
3. Increase Memory/CPU

---

## 📝 CHECKLIST BEFORE DEPLOY

- [ ] GitHub repository created and pushed
- [ ] Dockerfile exists in root
- [ ] requirements.txt updated
- [ ] railway.json created
- [ ] All env vars filled (see template)
- [ ] BOT_TOKEN is valid
- [ ] DATABASE_URI is valid
- [ ] ADMINS and CHANNELS IDs added
- [ ] LOG_CHANNEL ID correct
- [ ] No .env file committed
- [ ] No hardcoded credentials

---

## ✅ DEPLOYMENT COMPLETE WHEN:

1. ✅ Railway shows "Deployed" status (green)
2. ✅ Logs show "Bot name is started now ❤️"
3. ✅ Bot responds to /start in Telegram
4. ✅ Admin receives startup message
5. ✅ No errors in Logs tab
6. ✅ Metrics show bot running (CPU/Memory)

---

## 🎉 YOU'RE DONE!

Your bot is now **LIVE on Railway** and will:
- ✅ Auto-restart on crashes
- ✅ Auto-deploy on git push
- ✅ Handle 1000s of concurrent users
- ✅ Scale automatically (Pro plan)
- ✅ Keep data safe in MongoDB

---

## 📚 LEARN MORE

- Full guide: `RAILWAY_DEPLOYMENT.md`
- Project analysis: `ANALYSIS.md`
- Environment template: `railway-env-template.txt`
- Railway docs: https://docs.railway.app
- Pyrogram docs: https://docs.pyrogram.org

---

## 🆘 STILL NEED HELP?

1. Check Logs tab for error messages
2. Read RAILWAY_DEPLOYMENT.md full guide
3. Check Railway Discord: https://discord.gg/railway
4. Check Pyrogram Discord: https://discord.gg/pyrogram

**Happy botting! 🤖🚀**

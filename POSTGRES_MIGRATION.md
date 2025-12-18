# PostgreSQL Migration Guide

## Overview

This guide explains how to migrate from SQLite to PostgreSQL to fix the data persistence issue on Render's free tier.

## Prerequisites

- PostgreSQL database (local or cloud-hosted)
- Node.js and npm installed

## Local Development Setup

### 1. Install PostgreSQL Locally

**macOS (using Homebrew):**
```bash
brew install postgresql@15
brew services start postgresql@15
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
```

**Windows:**
Download and install from [postgresql.org](https://www.postgresql.org/download/windows/)

### 2. Create Database

```bash
# Connect to PostgreSQL
psql postgres

# Create database
CREATE DATABASE educate_a_girl;

# Exit psql
\q
```

### 3. Set Up Environment Variables

```bash
cd Eduacate_A_GIRL-b
cp .env.example .env
```

Edit `.env` and set your database URL:
```
DATABASE_URL=postgresql://localhost:5432/educate_a_girl
NODE_ENV=development
```

### 4. Install Dependencies

```bash
npm install
```

### 5. Seed the Database

```bash
node seed-postgres.js
```

### 6. Start the Server

```bash
npm start
```

The server should now be running on `http://localhost:3001` with PostgreSQL!

## Render.com Deployment

### 1. Create PostgreSQL Database on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"PostgreSQL"**
3. Configure:
   - **Name**: `educate-a-girl-db`
   - **Database**: `educate_a_girl`
   - **User**: (auto-generated)
   - **Region**: Same as your web service
   - **Plan**: **Free** (or paid for better performance)
4. Click **"Create Database"**
5. Copy the **Internal Database URL** (starts with `postgresql://`)

### 2. Update Web Service Environment Variables

1. Go to your web service on Render
2. Navigate to **"Environment"** tab
3. Add environment variable:
   - **Key**: `DATABASE_URL`
   - **Value**: (paste the Internal Database URL from step 1)
4. Click **"Save Changes"**

### 3. Deploy Updated Code

```bash
git add .
git commit -m "Migrate from SQLite to PostgreSQL"
git push origin main
```

Render will automatically redeploy your service.

### 4. Seed the Production Database

After deployment completes:

1. Go to your web service on Render
2. Click **"Shell"** tab
3. Run:
```bash
node seed-postgres.js
```

## Verification

### Test Data Persistence

1. **Add a gallery item** via the Admin panel
2. **Delete a shop product** via the Admin panel
3. **Wait 20 minutes** (or manually restart the service on Render)
4. **Refresh the pages**
5. **Verify**: New items should still be present, deleted items should still be gone

### Check Database Directly

**Local:**
```bash
psql postgresql://localhost:5432/educate_a_girl
SELECT COUNT(*) FROM gallery;
SELECT COUNT(*) FROM products;
\q
```

**Render (via Shell):**
```bash
psql $DATABASE_URL
SELECT COUNT(*) FROM gallery;
SELECT COUNT(*) FROM products;
\q
```

## Troubleshooting

### Connection Errors

**Error**: `ECONNREFUSED` or `Connection refused`
- **Solution**: Ensure PostgreSQL is running locally or the DATABASE_URL is correct

### Migration Errors

**Error**: `relation "products" does not exist`
- **Solution**: Run the seed script: `node seed-postgres.js`

### SSL Errors on Render

**Error**: `self signed certificate`
- **Solution**: The code already handles this with `ssl: { rejectUnauthorized: false }` in production

## Rollback (If Needed)

If you need to rollback to SQLite:

1. Restore `package.json` dependencies:
```json
"sqlite3": "^5.1.7"
```

2. Restore original `server.js` database connection
3. Remove `db.js` and `seed-postgres.js`
4. Redeploy

## Benefits of PostgreSQL

✅ **Persistent Storage** - Data survives server restarts
✅ **Better Performance** - Optimized for concurrent connections
✅ **Production-Ready** - Industry standard for web applications
✅ **Free Tier Available** - Render, Supabase, Railway all offer free PostgreSQL
✅ **Scalability** - Easy to upgrade as your app grows

## Support

If you encounter any issues, check:
- Render logs for error messages
- PostgreSQL connection string is correct
- Database has been seeded
- Environment variables are set correctly

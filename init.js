import fs from 'fs';
import pool from './db.js';
import { gallery, stories, team, journey, partners, programs, settings } from './data.js';

// Global lock to prevent multiple simultaneous initializations
let isInitializing = false;
let initPromise = null;

const runStartupMigrations = async () => {
    const migrations = [
        {
            name: 'products.stock',
            query: 'ALTER TABLE products ADD COLUMN IF NOT EXISTS stock INTEGER DEFAULT 0'
        },
        {
            name: 'products.offer_price',
            query: 'ALTER TABLE products ADD COLUMN IF NOT EXISTS offer_price DECIMAL(10, 2)'
        },
        {
            name: 'programs.header',
            query: 'ALTER TABLE programs ADD COLUMN IF NOT EXISTS header VARCHAR(255)'
        },
        {
            name: 'programs.dropdown_title',
            query: 'ALTER TABLE programs ADD COLUMN IF NOT EXISTS dropdown_title VARCHAR(255)'
        },
        {
            name: 'partners.table',
            query: `
                CREATE TABLE IF NOT EXISTS partners (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(255) NOT NULL,
                    logo TEXT NOT NULL,
                    website TEXT,
                    description TEXT,
                    sort_order INTEGER DEFAULT 0
                )
            `
        }
    ];

    for (const migration of migrations) {
        await pool.query(migration.query);
        console.log(`✓ Migration complete: ${migration.name}`);
    }
};

const init = async () => {
    // If already initializing, wait for that to complete
    if (isInitializing && initPromise) {
        console.log('⏳ Initialization already in progress, waiting...');
        return initPromise;
    }

    // If already initialized, skip
    if (isInitializing === 'complete') {
        console.log('✓ Database already initialized.');
        return;
    }

    isInitializing = true;
    const schema = fs.readFileSync('./schema.sql', 'utf8');

    initPromise = (async () => {
        try {
            console.log('Initializing database...');

            // Create tables
            await pool.query(schema);
            console.log('✓ Tables created or already exist.');

            // Apply startup migrations in sequence so new schema updates run after older ones.
            await runStartupMigrations();

            // Create blog_posts table if it doesn't exist
            try {
                await pool.query(`
                    CREATE TABLE IF NOT EXISTS blog_posts (
                        id SERIAL PRIMARY KEY,
                        title TEXT NOT NULL,
                        slug TEXT UNIQUE NOT NULL,
                        excerpt TEXT,
                        content TEXT,
                        image TEXT,
                        author TEXT DEFAULT 'EARG Team',
                        published BOOLEAN DEFAULT false,
                        published_at TIMESTAMPTZ DEFAULT NOW()
                    )
                `);
                console.log('✓ blog_posts table ready.');
            } catch (err) {
                console.log('Blog table note: ' + err.message);
            }

            // Check if data already exists
            const { rows } = await pool.query('SELECT COUNT(*) FROM products');
            const productCount = parseInt(rows[0].count);

            if (productCount > 0) {
                console.log(`✓ Database already has ${productCount} products. Skipping seed.`);
                isInitializing = 'complete';
                return;
            }

            console.log('Database is empty. Seeding initial data...');

            // Insert gallery
            for (const item of gallery) {
                await pool.query('INSERT INTO gallery (url, caption) VALUES ($1, $2)', [item.url, item.caption]);
            }
            console.log('✓ Gallery seeded.');

            // Insert stories
            for (const item of stories) {
                await pool.query('INSERT INTO stories (name, role, image, quote, featured) VALUES ($1, $2, $3, $4, $5)', [item.name, item.role, item.image, item.quote, item.featured]);
            }
            console.log('✓ Stories seeded.');

            // Insert team
            for (const item of team) {
                await pool.query('INSERT INTO team (name, role, image) VALUES ($1, $2, $3)', [item.name, item.role, item.image]);
            }
            console.log('✓ Team seeded.');

            // Insert journey
            for (const item of journey) {
                await pool.query('INSERT INTO journey (year, title, description) VALUES ($1, $2, $3)', [item.year, item.title, item.description]);
            }
            console.log('✓ Journey seeded.');

            // Insert partners
            for (const item of partners) {
                await pool.query(
                    'INSERT INTO partners (name, logo, website, description, sort_order) VALUES ($1, $2, $3, $4, $5)',
                    [item.name, item.logo, item.website || '', item.description || '', item.sort_order || 0]
                );
            }
            console.log('✓ Partners seeded.');

            // Insert programs
            for (const item of programs) {
                await pool.query('INSERT INTO programs (title, description, image, features) VALUES ($1, $2, $3, $4)', [item.title, item.description, item.image, JSON.stringify(item.features)]);
            }
            console.log('✓ Programs seeded.');

            // Insert settings (use ON CONFLICT to handle duplicates gracefully)
            for (const [key, value] of Object.entries(settings)) {
                await pool.query('INSERT INTO settings (key, value) VALUES ($1, $2) ON CONFLICT (key) DO NOTHING', [key, JSON.stringify(value)]);
            }
            console.log('✓ Settings seeded.');

            console.log('✓ Database initialization complete!');
            isInitializing = 'complete';
        } catch (err) {
            console.error('❌ Error initializing database:', err);
            isInitializing = false;
            initPromise = null;
            throw err;
        }
    })();

    return initPromise;
};

export default init;

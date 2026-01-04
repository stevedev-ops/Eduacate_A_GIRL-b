import fs from 'fs';
import pool from './db.js';
import { gallery, stories, team, journey, programs, settings } from './data.js';

const init = async () => {
    const schema = fs.readFileSync('./schema.sql', 'utf8');

    try {
        console.log('Initializing database...');

        // Create tables
        await pool.query(schema);
        console.log('✓ Tables created or already exist.');

        // Check if data already exists
        const { rows } = await pool.query('SELECT COUNT(*) FROM products');
        const productCount = parseInt(rows[0].count);

        if (productCount > 0) {
            console.log(`✓ Database already has ${productCount} products. Skipping seed.`);
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

        // Insert programs
        for (const item of programs) {
            await pool.query('INSERT INTO programs (title, description, image, features) VALUES ($1, $2, $3, $4)', [item.title, item.description, item.image, JSON.stringify(item.features)]);
        }
        console.log('✓ Programs seeded.');

        // Insert settings
        for (const [key, value] of Object.entries(settings)) {
            await pool.query('INSERT INTO settings (key, value) VALUES ($1, $2)', [key, JSON.stringify(value)]);
        }
        console.log('✓ Settings seeded.');

        console.log('✓ Database initialization complete!');
    } catch (err) {
        console.error('❌ Error initializing database:', err);
        throw err;
    }
};

// Run initialization and keep pool open for the server
init().catch(err => {
    console.error('Failed to initialize database:', err);
    process.exit(1);
});

export default init;

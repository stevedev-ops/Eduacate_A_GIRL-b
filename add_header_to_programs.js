import pool from './db.js';

const migrate = async () => {
    try {
        console.log('Starting migration: Adding header column to programs table...');

        // Check if column exists
        const checkQuery = `
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name='programs' AND column_name='header';
        `;
        const { rows } = await pool.query(checkQuery);

        if (rows.length === 0) {
            await pool.query('ALTER TABLE programs ADD COLUMN header VARCHAR(255)');
            console.log('Column "header" added successfully.');
        } else {
            console.log('Column "header" already exists.');
        }

        console.log('Migration completed successfully.');
        process.exit(0);
    } catch (err) {
        console.error('Migration failed:', err);
        process.exit(1);
    }
};

migrate();

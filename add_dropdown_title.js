import pool from './db.js';

const migrate = async () => {
    try {
        console.log('Migrating database...');

        // Add dropdown_title column to programs table if it doesn't exist
        await pool.query(`
            ALTER TABLE programs 
            ADD COLUMN IF NOT EXISTS dropdown_title VARCHAR(255);
        `);

        console.log('Migration completed successfully.');
        process.exit(0);
    } catch (err) {
        console.error('Migration failed:', err);
        process.exit(1);
    }
};

migrate();

require('dotenv').config();
const { Pool } = require('pg');

// PostgreSQL connection pool
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Helper for query execution
const query = async (sql, params = []) => {
    const client = await pool.connect();
    try {
        // Convert SQLite ? placeholders to PostgreSQL $1, $2, etc.
        let pgSql = sql;
        let paramIndex = 1;
        pgSql = pgSql.replace(/\?/g, () => `$${paramIndex++}`);

        const result = await client.query(pgSql, params);
        return result.rows;
    } finally {
        client.release();
    }
};

const getOne = async (sql, params = []) => {
    const rows = await query(sql, params);
    return rows[0] || null;
};

const run = async (sql, params = []) => {
    const client = await pool.connect();
    try {
        // Convert SQLite ? placeholders to PostgreSQL $1, $2, etc.
        let pgSql = sql;
        let paramIndex = 1;
        pgSql = pgSql.replace(/\?/g, () => `$${paramIndex++}`);

        // Add RETURNING id for INSERT statements to get the inserted ID
        if (pgSql.trim().toUpperCase().startsWith('INSERT') && !pgSql.toUpperCase().includes('RETURNING')) {
            pgSql += ' RETURNING id';
        }

        const result = await client.query(pgSql, params);

        // Return format compatible with SQLite's run() function
        return {
            lastID: result.rows[0]?.id,
            changes: result.rowCount
        };
    } finally {
        client.release();
    }
};

module.exports = { pool, query, getOne, run };

const { execSync } = require('child_process');

console.log('Starting application from index.js...');

try {
    // Run database initialization
    console.log('Running database initialization...');
    execSync('node init-db.js', { stdio: 'inherit' });
    console.log('Database initialization complete.');

    // Start the server
    console.log('Starting server.js...');
    require('./server.js');
} catch (error) {
    console.error('Failed to start application:', error);
    process.exit(1);
}

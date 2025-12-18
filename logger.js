const fs = require('fs');
const path = require('path');

const logFile = path.join(__dirname, 'error.log');

const logError = (error, context = '') => {
    const timestamp = new Date().toISOString();
    const errorMessage = error instanceof Error ? error.stack : (error.message || error);
    const logMessage = `[${timestamp}] ${context ? `[${context}] ` : ''}${errorMessage}\n----------------------------------------\n`;

    fs.appendFile(logFile, logMessage, (err) => {
        if (err) console.error('Failed to write to log file:', err);
    });

    // Always print to console key info
    console.error(`[ERROR] ${context}: ${error.message || error}`);
};

module.exports = { logError };

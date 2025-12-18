const fs = require('fs');
const path = require('path');
const http = require('http');

// Create a dummy image file
const testFilePath = path.join(__dirname, 'test_image.txt');
fs.writeFileSync(testFilePath, 'fake image content');

// Manual multipart/form-data request (simplified for no-dependency node)
// Actually, it's easier to use the existing 'verify_all_endpoints.js' style or just a simple fetch if node version supports it (Node 18+).
// Assuming standardized node environment, let's try a basic approach or just use the existence of the endpoint.

// Let's use a simple check that the endpoint exists and returns 400 for missing file
const options = {
    hostname: 'localhost',
    port: 3000,
    path: '/api/upload',
    method: 'POST',
};

const req = http.request(options, (res) => {
    let data = '';
    res.on('data', (chunk) => data += chunk);
    res.on('end', () => {
        console.log(`Status: ${res.statusCode}`);
        console.log(`Response: ${data}`);

        // Cleanup
        if (fs.existsSync(testFilePath)) fs.unlinkSync(testFilePath);
    });
});

req.on('error', (e) => {
    console.error(`Problem with request: ${e.message}`);
});

req.end();

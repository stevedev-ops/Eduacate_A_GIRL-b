const http = require('http');

const endpoints = [
    '/api/products',
    '/api/gallery',
    '/api/stories',
    '/api/team',
    '/api/journey',
    '/api/settings/home_products',
    '/api/settings/categories',
    '/api/programs',
    '/api/messages',
    '/api/settings/contact_info',
    '/api/settings/impact_stats',
    '/api/settings/home_hero',
    '/api/settings/about_hero'
];

async function checkEndpoint(path) {
    return new Promise((resolve) => {
        http.get('http://localhost:3001' + path, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    try {
                        JSON.parse(data);
                        console.log(`[PASS] ${path}`);
                        resolve(true);
                    } catch (e) {
                        console.log(`[FAIL] ${path} - Invalid JSON`);
                        resolve(false);
                    }
                } else {
                    console.log(`[FAIL] ${path} - Status ${res.statusCode}: ${data}`);
                    resolve(false);
                }
            });
        }).on('error', (err) => {
            console.log(`[FAIL] ${path} - Request Error: ${err.message}`);
            resolve(false);
        });
    });
}

(async () => {
    console.log("Verifying all endpoints...");
    let success = true;
    for (const ep of endpoints) {
        if (!await checkEndpoint(ep)) success = false;
    }
    if (!success) {
        console.log("\nSome endpoints failed.");
        process.exit(1);
    }
    console.log("\nAll endpoints passed.");
})();

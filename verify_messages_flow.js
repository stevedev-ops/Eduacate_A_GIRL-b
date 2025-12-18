const http = require('http');

function request(options, data) {
    return new Promise((resolve, reject) => {
        const req = http.request(options, (res) => {
            let body = '';
            res.on('data', chunk => body += chunk);
            res.on('end', () => resolve(JSON.parse(body)));
        });
        req.on('error', reject);
        if (data) req.write(JSON.stringify(data));
        req.end();
    });
}

(async () => {
    try {
        console.log("1. Fetching initial messages...");
        const initial = await request({
            hostname: 'localhost', port: 3001, path: '/api/messages', method: 'GET'
        });
        console.log(`   Initial count: ${initial.data.length}`);

        console.log("2. Sending a new message...");
        const testMsg = {
            name: "Test User",
            email: "test@example.com",
            message: "Automated verification message " + Date.now()
        };
        await request({
            hostname: 'localhost', port: 3001, path: '/api/messages', method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        }, testMsg);
        console.log("   Message sent.");

        console.log("3. Fetching messages again...");
        const final = await request({
            hostname: 'localhost', port: 3001, path: '/api/messages', method: 'GET'
        });
        console.log(`   Final count: ${final.data.length}`);

        const found = final.data.find(m => m.message === testMsg.message);
        if (found) {
            console.log("SUCCESS: Message found in backend!");
        } else {
            console.error("FAILURE: Message not found!");
            process.exit(1);
        }

    } catch (err) {
        console.error("Error:", err);
        process.exit(1);
    }
})();

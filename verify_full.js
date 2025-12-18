const http = require('http');

console.log("Verifying Programs...");
http.get('http://localhost:3000/api/programs', (res) => {
    let data = '';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
        console.log("Programs response:", data);
    });
});

console.log("Verifying Messages...");
const msg = JSON.stringify({ name: "Verifier", email: "test@verify.com", message: "Verification Check" });
const req = http.request({
    hostname: 'localhost',
    port: 3000,
    path: '/api/messages',
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Content-Length': msg.length
    }
}, (res) => {
    let data = '';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
        console.log("Message Submit:", data);

        // Verify we can read it back
        http.get('http://localhost:3000/api/messages', (res2) => {
            let data2 = '';
            res2.on('data', chunk => data2 += chunk);
            res2.on('end', () => {
                console.log("Messages List:", data2);
            });
        });
    });
});
req.write(msg);
req.end();

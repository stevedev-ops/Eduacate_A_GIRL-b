const http = require('http');

const data = JSON.stringify({
    name: "Node Script Test Product",
    price: 25,
    category: "Test",
    description: "Created via node script",
    material: "Bits",
    dimensions: "1x1",
    origin: "Localhost",
    impact: "High",
    images: ["https://via.placeholder.com/150"]
});

const options = {
    hostname: 'localhost',
    port: 3000,
    path: '/api/products',
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Content-Length': data.length
    }
};

const req = http.request(options, (res) => {
    console.log(`STATUS: ${res.statusCode}`);
    res.setEncoding('utf8');
    res.on('data', (chunk) => {
        console.log(`BODY: ${chunk}`);
    });
});

req.on('error', (e) => {
    console.error(`problem with request: ${e.message}`);
});

req.write(data);
req.end();

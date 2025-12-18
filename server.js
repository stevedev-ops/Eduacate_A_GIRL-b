const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');
const path = require('path');
const { logError } = require('./logger');
const multer = require('multer');

const app = express();
const PORT = 3001;

// Middleware
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const fs = require('fs');

// Ensure uploads directory exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

// Configure multer for file uploads with validation
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

// File filter to only accept images
const fileFilter = (req, file, cb) => {
    const allowedMimeTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp', 'image/svg+xml'];

    if (allowedMimeTypes.includes(file.mimetype)) {
        cb(null, true); // Accept file
    } else {
        cb(new Error(`Invalid file type. Only image files are allowed (JPEG, PNG, GIF, WebP, SVG). Received: ${file.mimetype}`), false);
    }
};

const upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024 // 5MB max file size
    }
});

// Database Setup
const dbPath = path.resolve(__dirname, 'database.sqlite');
const db = new sqlite3.Database(dbPath, (err) => {
    if (err) {
        console.error('Error opening database', err.message);
    } else {
        console.log('Connected to the SQLite database.');
        createTables();
    }
});

function createTables() {
    // Tables are created via seed.js for simplicity, but we can ensure they exist here too
    // Keeping simple to avoid duplication logic complexity here
}

// Helper for query execution (Promisify-ish)
const run = (sql, params = []) => {
    return new Promise((resolve, reject) => {
        db.run(sql, params, function (err) {
            if (err) reject(err);
            else resolve(this);
        });
    });
};

const query = (sql, params = []) => {
    return new Promise((resolve, reject) => {
        db.all(sql, params, (err, rows) => {
            if (err) reject(err);
            else resolve(rows);
        });
    });
};

const getOne = (sql, params = []) => {
    return new Promise((resolve, reject) => {
        db.get(sql, params, (err, row) => {
            if (err) reject(err);
            else resolve(row);
        });
    });
};

// --- ROUTES ---

// PRODUCTS
app.get('/api/products', async (req, res) => {
    try {
        const rows = await query("SELECT * FROM products");
        const products = rows.map(p => ({
            ...p,
            details: JSON.parse(p.details),
            story: JSON.parse(p.story),
            images: JSON.parse(p.images)
        }));
        res.json({ message: "success", data: products });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.get('/api/products/:id', async (req, res) => {
    try {
        const row = await getOne("SELECT * FROM products WHERE id = ?", [req.params.id]);
        if (row) {
            res.json({
                message: "success",
                data: {
                    ...row,
                    details: JSON.parse(row.details),
                    story: JSON.parse(row.story),
                    images: JSON.parse(row.images)
                }
            });
        } else {
            res.status(404).json({ "error": "Product not found" });
        }
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/products', async (req, res) => {
    const { name, price, category, description, material, dimensions, origin, impact, details, story, images, stock, offerPrice } = req.body;
    const id = 'p' + Date.now();
    try {
        await run(
            "INSERT INTO products (id, name, price, category, rating, reviews, description, material, dimensions, origin, impact, details, story, images, stock, offerPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [id, name, price, category, 0, 0, description, material, dimensions, origin, impact, JSON.stringify(details || []), JSON.stringify(story || null), JSON.stringify(images || []), stock || 0, offerPrice || null]
        );
        res.json({ message: "success", id });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.put('/api/products/:id', async (req, res) => {
    const { name, price, category, description, material, dimensions, origin, impact, details, story, images, stock, offerPrice } = req.body;
    try {
        await run(
            "UPDATE products SET name = ?, price = ?, category = ?, description = ?, material = ?, dimensions = ?, origin = ?, impact = ?, details = ?, story = ?, images = ?, stock = ?, offerPrice = ? WHERE id = ?",
            [name, price, category, description, material, dimensions, origin, impact, JSON.stringify(details || []), JSON.stringify(story || null), JSON.stringify(images || []), stock || 0, offerPrice || null, req.params.id]
        );
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.delete('/api/products/:id', async (req, res) => {
    try {
        await run("DELETE FROM products WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// GALLERY
app.get('/api/gallery', async (req, res) => {
    try {
        const rows = await query("SELECT * FROM gallery");
        res.json({ message: "success", data: rows });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/gallery', async (req, res) => {
    const { url, caption } = req.body;
    try {
        const result = await run("INSERT INTO gallery (url, caption) VALUES (?, ?)", [url, caption]);
        res.json({ message: "success", id: result.lastID });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.delete('/api/gallery/:id', async (req, res) => {
    try {
        await run("DELETE FROM gallery WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// STORIES
app.get('/api/stories', async (req, res) => {
    try {
        const rows = await query("SELECT * FROM stories");
        // Convert featured to boolean
        const data = rows.map(r => ({ ...r, featured: !!r.featured }));
        res.json({ message: "success", data });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/stories', async (req, res) => {
    const { name, role, image, quote, featured } = req.body;
    try {
        const result = await run(
            "INSERT INTO stories (name, role, image, quote, featured) VALUES (?, ?, ?, ?, ?)",
            [name, role, image, quote, featured ? 1 : 0]
        );
        res.json({ message: "success", id: result.lastID });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.put('/api/stories/:id', async (req, res) => {
    const { name, role, image, quote, featured } = req.body;
    try {
        await run(
            "UPDATE stories SET name = ?, role = ?, image = ?, quote = ?, featured = ? WHERE id = ?",
            [name, role, image, quote, featured ? 1 : 0, req.params.id]
        );
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.delete('/api/stories/:id', async (req, res) => {
    try {
        await run("DELETE FROM stories WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// TEAM
app.get('/api/team', async (req, res) => {
    try {
        const rows = await query("SELECT * FROM team");
        res.json({ message: "success", data: rows });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/team', async (req, res) => {
    const { name, role, image } = req.body;
    try {
        const result = await run(
            "INSERT INTO team (name, role, image) VALUES (?, ?, ?)",
            [name, role, image]
        );
        res.json({ message: "success", id: result.lastID });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.put('/api/team/:id', async (req, res) => {
    const { name, role, image } = req.body;
    try {
        await run(
            "UPDATE team SET name = ?, role = ?, image = ? WHERE id = ?",
            [name, role, image, req.params.id]
        );
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.delete('/api/team/:id', async (req, res) => {
    try {
        await run("DELETE FROM team WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// JOURNEY
app.get('/api/journey', async (req, res) => {
    try {
        const rows = await query("SELECT * FROM journey ORDER BY year DESC");
        res.json({ message: "success", data: rows });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/journey', async (req, res) => {
    const { year, title, description } = req.body;
    try {
        const result = await run(
            "INSERT INTO journey (year, title, description) VALUES (?, ?, ?)",
            [year, title, description]
        );
        res.json({ message: "success", id: result.lastID });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.put('/api/journey/:id', async (req, res) => {
    const { year, title, description } = req.body;
    try {
        await run(
            "UPDATE journey SET year = ?, title = ?, description = ? WHERE id = ?",
            [year, title, description, req.params.id]
        );
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.delete('/api/journey/:id', async (req, res) => {
    try {
        await run("DELETE FROM journey WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// SETTINGS (Home Products)
app.get('/api/settings/home_products', async (req, res) => {
    try {
        const row = await getOne("SELECT value FROM settings WHERE key = 'home_products'");
        const ids = row ? JSON.parse(row.value) : [];
        res.json({ message: "success", data: ids });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/settings/home_products', async (req, res) => {
    const { ids } = req.body;
    try {
        // Upsert style
        const exists = await getOne("SELECT id FROM settings WHERE key = 'home_products'");
        if (exists) {
            await run("UPDATE settings SET value = ? WHERE key = 'home_products'", [JSON.stringify(ids)]);
        } else {
            await run("INSERT INTO settings (key, value) VALUES (?, ?)", ['home_products', JSON.stringify(ids)]);
        }
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// CATEGORIES
app.get('/api/settings/categories', async (req, res) => {
    try {
        const row = await getOne("SELECT value FROM settings WHERE key = 'categories'");
        const categories = row ? JSON.parse(row.value) : ['Handmade Crafts', 'Sustainable Apparel', 'Jewelry', 'Eco-Friendly']; // Fallback defaults
        res.json({ message: "success", data: categories });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

app.post('/api/settings/categories', async (req, res) => {
    const { categories } = req.body;
    try {
        const exists = await getOne("SELECT id FROM settings WHERE key = 'categories'");
        if (exists) {
            await run("UPDATE settings SET value = ? WHERE key = 'categories'", [JSON.stringify(categories)]);
        } else {
            await run("INSERT INTO settings (key, value) VALUES (?, ?)", ['categories', JSON.stringify(categories)]);
        }
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});

// --- PROGRAMS ---
app.get('/api/programs', async (req, res) => {
    try {
        const programs = await query("SELECT * FROM programs");
        res.json({ message: "success", data: programs.map(p => ({ ...p, features: JSON.parse(p.features || '[]') })) });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.post('/api/programs', async (req, res) => {
    const { title, description, image, features } = req.body;
    try {
        const result = await run(
            "INSERT INTO programs (title, description, image, features) VALUES (?, ?, ?, ?)",
            [title, description, image, JSON.stringify(features)]
        );
        res.json({ message: "success", id: result.id });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.put('/api/programs/:id', async (req, res) => {
    const { title, description, image, features } = req.body;
    try {
        await run(
            "UPDATE programs SET title = ?, description = ?, image = ?, features = ? WHERE id = ?",
            [title, description, image, JSON.stringify(features), req.params.id]
        );
        res.json({ message: "success" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.delete('/api/programs/:id', async (req, res) => {
    try {
        await run("DELETE FROM programs WHERE id = ?", [req.params.id]);
        res.json({ message: "deleted" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

// --- MESSAGES (Contact Form) ---
app.get('/api/messages', async (req, res) => {
    try {
        const messages = await query("SELECT * FROM messages ORDER BY date DESC");
        // Convert read to boolean
        const data = messages.map(m => ({ ...m, read: !!m.read }));
        res.json({ message: "success", data });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.post('/api/messages', async (req, res) => {
    const { name, email, message } = req.body;
    try {
        await run(
            "INSERT INTO messages (name, email, message, date, read) VALUES (?, ?, ?, ?, 0)",
            [name, email, message, new Date().toISOString()]
        );
        res.json({ message: "success" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.put('/api/messages/:id/read', async (req, res) => {
    const { read } = req.body;
    try {
        await run("UPDATE messages SET read = ? WHERE id = ?", [read ? 1 : 0, req.params.id]);
        res.json({ message: "success" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.delete('/api/messages/:id', async (req, res) => {
    try {
        await run("DELETE FROM messages WHERE id = ?", [req.params.id]);
        res.json({ message: "deleted" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

// --- REVIEWS ---
app.post('/api/reviews', async (req, res) => {
    const { product_id, user_name, user_email, rating, comment } = req.body;
    try {
        const result = await run(
            "INSERT INTO reviews (product_id, user_name, user_email, rating, comment, approved, created_at) VALUES (?, ?, ?, ?, ?, 0, ?)",
            [product_id, user_name, user_email || null, rating, comment, new Date().toISOString()]
        );
        res.json({ message: "success", id: result.lastID });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.get('/api/reviews/product/:productId', async (req, res) => {
    try {
        const reviews = await query("SELECT * FROM reviews WHERE product_id = ? AND approved = 1 ORDER BY created_at DESC", [req.params.productId]);
        res.json({ message: "success", data: reviews });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.get('/api/reviews/pending', async (req, res) => {
    try {
        const reviews = await query(`
            SELECT r.*, p.name as product_name 
            FROM reviews r 
            LEFT JOIN products p ON r.product_id = p.id 
            WHERE r.approved = 0 
            ORDER BY r.created_at DESC
        `);
        res.json({ message: "success", data: reviews });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.put('/api/reviews/:id/approve', async (req, res) => {
    try {
        await run("UPDATE reviews SET approved = 1 WHERE id = ?", [req.params.id]);
        res.json({ message: "success" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.delete('/api/reviews/:id', async (req, res) => {
    try {
        await run("DELETE FROM reviews WHERE id = ?", [req.params.id]);
        res.json({ message: "deleted" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

// --- SETTINGS (Generic) ---
// Keys: 'home_hero', 'about_hero', 'impact_stats', 'contact_info'
app.get('/api/settings/:key', async (req, res) => {
    try {
        const row = await getOne("SELECT value FROM settings WHERE key = ?", [req.params.key]);
        res.json({ message: "success", data: row ? JSON.parse(row.value) : null });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});

app.post('/api/settings/:key', async (req, res) => {
    const { value } = req.body;
    try {
        const exists = await getOne("SELECT id FROM settings WHERE key = ?", [req.params.key]);
        if (exists) {
            await run("UPDATE settings SET value = ? WHERE key = ?", [JSON.stringify(value), req.params.key]);
        } else {
            await run("INSERT INTO settings (key, value) VALUES (?, ?)", [req.params.key, JSON.stringify(value)]);
        }
        res.json({ message: "success" });
    } catch (err) { logError(err); res.status(400).json({ "error": err.message }); }
});
// CHECKOUT
app.post('/api/checkout', async (req, res) => {
    const { items } = req.body; // Expects [{ id: 'p1', quantity: 1 }]
    try {
        // 1. Validate Stock
        for (const item of items) {
            const product = await getOne("SELECT stock, name FROM products WHERE id = ?", [item.id]);
            if (!product) throw new Error(`Product ${item.id} not found`);
            if (product.stock < item.quantity) {
                throw new Error(`Insufficient stock for ${product.name}. Available: ${product.stock}`);
            }
        }

        // 2. Process "Payment" (Simulated)
        // In real app, integrate Stripe/Paystack here.

        // 3. Decrement Stock
        for (const item of items) {
            await run("UPDATE products SET stock = stock - ? WHERE id = ?", [item.quantity, item.id]);
        }

        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ "error": err.message });
    }
});


// SEARCH
app.get('/api/search', async (req, res) => {
    const { q } = req.query;
    try {
        const results = await query(
            "SELECT * FROM products WHERE name LIKE ? OR description LIKE ? OR category LIKE ?",
            [`%${q}%`, `%${q}%`, `%${q}%`]
        );
        res.json({ message: "success", data: results });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

// ORDERS
app.post('/api/orders', async (req, res) => {
    const { email, name, items, total, payment_method } = req.body;
    const orderId = 'ORD' + Date.now();
    try {
        await run(
            "INSERT INTO orders (id, customer_email, customer_name, items, total, payment_method) VALUES (?, ?, ?, ?, ?, ?)",
            [orderId, email, name, JSON.stringify(items), total, payment_method]
        );
        res.json({ message: "success", orderId });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

app.get('/api/orders/:id', async (req, res) => {
    try {
        const order = await getOne("SELECT * FROM orders WHERE id = ?", [req.params.id]);
        if (!order) return res.status(404).json({ error: "Order not found" });
        order.items = JSON.parse(order.items);
        res.json({ message: "success", data: order });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

// WISHLIST
app.get('/api/wishlist/:sessionId', async (req, res) => {
    try {
        const items = await query("SELECT w.id, w.product_id, w.added_at, p.* FROM wishlist w JOIN products p ON w.product_id = p.id WHERE w.session_id = ?", [req.params.sessionId]);
        res.json({ message: "success", data: items });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

app.post('/api/wishlist', async (req, res) => {
    const { session_id, product_id } = req.body;
    console.log(`[WISHLIST] Adding: session=${session_id}, product=${product_id}`);
    try {
        const existing = await getOne("SELECT id FROM wishlist WHERE session_id = ? AND product_id = ?", [session_id, product_id]);
        if (existing) {
            console.log(`[WISHLIST] Found existing: id=${existing.id}`);
            return res.json({ message: "success", id: existing.id, note: "Item already in wishlist" });
        }
        const result = await run("INSERT INTO wishlist (session_id, product_id) VALUES (?, ?)", [session_id, product_id]);
        console.log(`[WISHLIST] Inserted new: id=${result.lastID}`);
        res.json({ message: "success", id: result.lastID });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

app.delete('/api/wishlist/:id', async (req, res) => {
    console.log(`[WISHLIST] Deleting id=${req.params.id}`);
    try {
        await run("DELETE FROM wishlist WHERE id = ?", [req.params.id]);
        console.log(`[WISHLIST] Deleted id=${req.params.id}`);
        res.json({ message: "success" });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});


// FILE UPLOAD
app.post('/api/upload', upload.single('image'), (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'No file uploaded' });
        }
        const fileUrl = `/uploads/${req.file.filename}`;
        res.json({ message: 'success', url: fileUrl });
    } catch (err) {
        logError(err);
        res.status(400).json({ error: err.message });
    }
});

// Handle multer errors (e.g., file type, size)
app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError) {
        if (err.code === 'LIMIT_FILE_SIZE') {
            return res.status(400).json({ error: 'File size too large. Maximum size is 5MB.' });
        }
        return res.status(400).json({ error: err.message });
    } else if (err) {
        logError(err);
        return res.status(400).json({ error: err.message });
    }
    next();
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

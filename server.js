import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import multer from 'multer';
import path from 'path';
import { fileURLToPath } from 'url';
import pool from './db.js';
import fs from 'fs';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Setup Cloudinary storage
import { v2 as cloudinary } from 'cloudinary';
import { CloudinaryStorage } from 'multer-storage-cloudinary';

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

const storage = new CloudinaryStorage({
    cloudinary: cloudinary,
    params: {
        folder: 'educate_a_girl',
        allowed_formats: ['jpg', 'png', 'jpeg', 'webp']
        // We store the original high-quality image without incoming transformations
    }
});

const upload = multer({ storage: storage });

app.post('/api/upload', (req, res) => {
    upload.single('image')(req, res, (err) => {
        if (err) {
            console.error('Upload Error:', err);
            return res.status(500).json({ error: err.message || 'File upload failed' });
        }
        if (!req.file) return res.status(400).json({ error: 'No file uploaded' });

        // Store the ORIGINAL Cloudinary URL without transformations
        // Transformations (q_auto, f_auto) will be applied in frontend via getImageUrl()
        const imageUrl = req.file.path;

        res.json({ url: imageUrl });
    });
});

// --- HELPER FOR QUERY ---
const runQuery = async (res, query, params) => {
    try {
        const { rows } = await pool.query(query, params);
        res.json(rows);
    } catch (err) {
        console.error("DB Error:", err);
        res.status(500).json({ error: err.message });
    }
};

const runQuerySingle = async (res, query, params) => {
    try {
        const { rows } = await pool.query(query, params);
        res.json(rows[0] || {});
    } catch (err) {
        console.error("DB Error:", err);
        res.status(500).json({ error: err.message });
    }
};

// --- PRODUCTS ---
app.get('/api/products', async (req, res) => runQuery(res, 'SELECT * FROM products ORDER BY id'));

app.get('/api/products/:id', async (req, res) => runQuerySingle(res, 'SELECT * FROM products WHERE id = $1', [req.params.id]));

app.post('/api/products', async (req, res) => {
    try {
        const { name, price, offerPrice, category, rating, reviews, description, material, dimensions, origin, impact, details, story, images, stock, id } = req.body;
        // Generate simple ID if not provided (though frontend usually relies on backend for ID generation, here we accept ID or gen one)
        const finalId = id || `prod_${Date.now()}`;
        const query = `INSERT INTO products (id, name, price, offer_price, category, rating, reviews, description, material, dimensions, origin, impact, details, story, images, stock) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16) RETURNING *`;
        const values = [finalId, name, price, offerPrice || null, category, rating || 5, reviews || 0, description, material, dimensions, origin, impact, JSON.stringify(details || []), JSON.stringify(story || {}), JSON.stringify(images || []), stock || 0];
        const { rows } = await pool.query(query, values);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/products/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { name, price, offerPrice, category, rating, reviews, description, material, dimensions, origin, impact, details, story, images, stock } = req.body;
        const query = `UPDATE products SET name=$1, price=$2, offer_price=$3, category=$4, rating=$5, reviews=$6, description=$7, material=$8, dimensions=$9, origin=$10, impact=$11, details=$12, story=$13, images=$14, stock=$15 WHERE id=$16 RETURNING *`;
        const values = [name, price, offerPrice || null, category, rating, reviews, description, material, dimensions, origin, impact, JSON.stringify(details), JSON.stringify(story), JSON.stringify(images), stock || 0, id];
        const { rows } = await pool.query(query, values);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/products/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM products WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- GALLERY ---
app.get('/api/gallery', async (req, res) => runQuery(res, 'SELECT * FROM gallery ORDER BY id DESC'));

app.post('/api/gallery', async (req, res) => {
    try {
        const { url, caption } = req.body;
        const { rows } = await pool.query('INSERT INTO gallery (url, caption) VALUES ($1, $2) RETURNING *', [url, caption]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/gallery/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM gallery WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- STORIES ---
app.get('/api/stories', async (req, res) => runQuery(res, 'SELECT * FROM stories ORDER BY id DESC'));

app.post('/api/stories', async (req, res) => {
    try {
        const { name, role, image, quote, featured } = req.body;
        const { rows } = await pool.query('INSERT INTO stories (name, role, image, quote, featured) VALUES ($1, $2, $3, $4, $5) RETURNING *', [name, role, image, quote, featured]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/stories/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { name, role, image, quote, featured } = req.body;
        const { rows } = await pool.query('UPDATE stories SET name=$1, role=$2, image=$3, quote=$4, featured=$5 WHERE id=$6 RETURNING *', [name, role, image, quote, featured, id]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/stories/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM stories WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- TEAM ---
app.get('/api/team', async (req, res) => runQuery(res, 'SELECT * FROM team ORDER BY id'));

app.post('/api/team', async (req, res) => {
    try {
        const { name, role, image } = req.body;
        const { rows } = await pool.query('INSERT INTO team (name, role, image) VALUES ($1, $2, $3) RETURNING *', [name, role, image]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/team/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { name, role, image } = req.body;
        const { rows } = await pool.query('UPDATE team SET name=$1, role=$2, image=$3 WHERE id=$4 RETURNING *', [name, role, image, id]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/team/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM team WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- JOURNEY ---
app.get('/api/journey', async (req, res) => runQuery(res, 'SELECT * FROM journey ORDER BY year'));

app.post('/api/journey', async (req, res) => {
    try {
        const { year, title, description } = req.body;
        const { rows } = await pool.query('INSERT INTO journey (year, title, description) VALUES ($1, $2, $3) RETURNING *', [year, title, description]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/journey/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { year, title, description } = req.body;
        const { rows } = await pool.query('UPDATE journey SET year=$1, title=$2, description=$3 WHERE id=$4 RETURNING *', [year, title, description, id]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/journey/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM journey WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- PROGRAMS ---
app.get('/api/programs', async (req, res) => runQuery(res, 'SELECT * FROM programs ORDER BY id'));

app.post('/api/programs', async (req, res) => {
    try {
        const { title, description, image, features } = req.body;
        const { rows } = await pool.query('INSERT INTO programs (title, description, image, features) VALUES ($1, $2, $3, $4) RETURNING *', [title, description, image, JSON.stringify(features)]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/programs/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { title, description, image, features } = req.body;
        // In some cases id is not in params but in body, being safe
        const { rows } = await pool.query('UPDATE programs SET title=$1, description=$2, image=$3, features=$4 WHERE id=$5 RETURNING *', [title, description, image, JSON.stringify(features), id]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/programs/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM programs WHERE id = $1', [req.params.id]);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- SETTINGS ---
app.get('/api/settings/:key', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT value FROM settings WHERE key=$1', [req.params.key]);
        res.json(rows[0]?.value || null);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/settings/:key', async (req, res) => {
    try {
        const { key } = req.params;
        const { value } = req.body;
        const query = 'INSERT INTO settings (key, value) VALUES ($1, $2) ON CONFLICT (key) DO UPDATE SET value = $2 RETURNING *';
        const { rows } = await pool.query(query, [key, JSON.stringify(value)]);
        res.json(rows[0].value);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- MESSAGES ---
app.get('/api/messages', async (req, res) => runQuery(res, 'SELECT * FROM messages ORDER BY date DESC'));

app.post('/api/messages', async (req, res) => {
    try {
        const { name, email, message } = req.body;
        const { rows } = await pool.query('INSERT INTO messages (name, email, message) VALUES ($1, $2, $3) RETURNING *', [name, email, message]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/messages/:id/read', async (req, res) => {
    try {
        const { read } = req.body;
        await pool.query('UPDATE messages SET read=$1 WHERE id=$2', [read, req.params.id]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/messages/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM messages WHERE id = $1', [req.params.id]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- REVIEWS ---
app.get('/api/reviews/product/:id', async (req, res) => {
    runQuery(res, "SELECT * FROM reviews WHERE product_id = $1 AND status = 'approved' ORDER BY date DESC", [req.params.id]);
});

app.get('/api/reviews/pending', async (req, res) => {
    runQuery(res, "SELECT * FROM reviews WHERE status = 'pending' ORDER BY date DESC");
});

app.post('/api/reviews', async (req, res) => {
    try {
        const { product_id, author, rating, comment, user_name, user_email } = req.body; // user_name/email map to author/email often
        // Schema says: product_id, rating, comment, author, status, date.
        // Frontend sends: user_name, user_email, rating, comment.
        const { rows } = await pool.query('INSERT INTO reviews (product_id, rating, comment, author) VALUES ($1, $2, $3, $4) RETURNING *', [product_id, rating, comment, user_name || author]);
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.put('/api/reviews/:id/approve', async (req, res) => {
    try {
        await pool.query("UPDATE reviews SET status='approved' WHERE id=$1", [req.params.id]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/reviews/:id', async (req, res) => {
    try {
        await pool.query('DELETE FROM reviews WHERE id=$1', [req.params.id]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});


// --- CHECKOUT & ORDERS ---
app.post('/api/checkout', async (req, res) => {
    res.json({ success: true, message: 'Payment processed successfully' });
});

app.post('/api/orders', async (req, res) => {
    try {
        const { items, total, customerInfo } = req.body;
        const { rows } = await pool.query('INSERT INTO orders (items, total, customer_info) VALUES ($1, $2, $3) RETURNING *', [JSON.stringify(items), total, JSON.stringify(customerInfo)]);
        res.status(201).json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/orders/:id', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT * FROM orders WHERE id = $1', [req.params.id]);
        if (rows.length === 0) return res.status(404).json({ error: 'Order not found' });
        res.json(rows[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- WISHLIST ---
app.get('/api/wishlist/:session_id', async (req, res) => {
    try {
        const { session_id } = req.params;
        const query = `
            SELECT w.id, w.product_id, p.name, p.price, p.description, p.images, p.stock, p.category
            FROM wishlist w
            JOIN products p ON w.product_id = p.id
            WHERE w.session_id = $1
        `;
        const { rows } = await pool.query(query, [session_id]);
        res.json({ message: 'success', data: rows });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.post('/api/wishlist', async (req, res) => {
    try {
        const { session_id, product_id } = req.body;
        const query = 'INSERT INTO wishlist (session_id, product_id) VALUES ($1, $2) ON CONFLICT (session_id, product_id) DO NOTHING RETURNING *';
        const { rows } = await pool.query(query, [session_id, product_id]);
        res.status(201).json({ message: 'success', data: rows[0] });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.delete('/api/wishlist/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query('DELETE FROM wishlist WHERE id = $1', [id]);
        res.json({ message: 'success' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

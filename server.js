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
        // to satisfy "Only store 1 good high-quality original"
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

        // Enforce q_auto,f_auto (Smart Optimization) in the URL
        // Rule: "Always use q_auto,f_auto... Keep URL consistent"
        let imageUrl = req.file.path;
        if (imageUrl.includes('/upload/')) {
            imageUrl = imageUrl.replace('/upload/', '/upload/q_auto,f_auto/');
        }

        res.json({ url: imageUrl });
    });
});


// --- CHECKOUT & ORDERS ---
app.post('/api/checkout', async (req, res) => {
    // Mock payment success
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

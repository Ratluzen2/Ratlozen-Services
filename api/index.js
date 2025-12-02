import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Health check - أساسي
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'Ratlozen Backend is running',
    timestamp: new Date(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Services endpoints
app.get('/api/services', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Services endpoint',
    data: []
  });
});

app.post('/api/services', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Service created',
    data: req.body
  });
});

// Products endpoints
app.get('/api/products', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Products endpoint',
    data: []
  });
});

app.post('/api/products', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Product created',
    data: req.body
  });
});

// Orders endpoints
app.get('/api/orders', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Orders endpoint',
    data: []
  });
});

app.post('/api/orders', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Order created',
    data: req.body
  });
});

// Wallet endpoints
app.get('/api/wallet', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Wallet endpoint',
    data: { balance: 0 }
  });
});

// Notifications endpoints
app.get('/api/notifications', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Notifications endpoint',
    data: []
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Not Found', message: 'Endpoint not found' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ error: 'Internal Server Error', message: err.message });
});

// تصدير للـ Vercel
export default app;

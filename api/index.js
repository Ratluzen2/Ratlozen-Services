import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Logging middleware
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Ratlozen Backend is running on Vercel',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'production',
    database: process.env.DATABASE_URL ? 'Configured' : 'Not configured',
    uptime: process.uptime()
  });
});

// Root endpoint
app.get('/', (req, res) => {
  res.status(200).json({
    message: 'Ratlozen Services Backend API',
    version: '1.0.0',
    status: 'running',
    endpoints: {
      health: '/api/health',
      services: '/api/services',
      products: '/api/products',
      orders: '/api/orders',
      wallet: '/api/wallet',
      notifications: '/api/notifications'
    }
  });
});

// Services endpoints
app.get('/api/services', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Services endpoint',
    data: [],
    timestamp: new Date().toISOString()
  });
});

app.post('/api/services', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Service created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.get('/api/services/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Service ${req.params.id}`,
    data: { id: req.params.id },
    timestamp: new Date().toISOString()
  });
});

app.put('/api/services/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Service ${req.params.id} updated`,
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.delete('/api/services/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Service ${req.params.id} deleted`,
    timestamp: new Date().toISOString()
  });
});

// Products endpoints
app.get('/api/products', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Products endpoint',
    data: [],
    timestamp: new Date().toISOString()
  });
});

app.post('/api/products', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Product created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.get('/api/products/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Product ${req.params.id}`,
    data: { id: req.params.id },
    timestamp: new Date().toISOString()
  });
});

app.put('/api/products/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Product ${req.params.id} updated`,
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.delete('/api/products/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Product ${req.params.id} deleted`,
    timestamp: new Date().toISOString()
  });
});

// Orders endpoints
app.get('/api/orders', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Orders endpoint',
    data: [],
    timestamp: new Date().toISOString()
  });
});

app.post('/api/orders', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Order created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.get('/api/orders/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Order ${req.params.id}`,
    data: { id: req.params.id },
    timestamp: new Date().toISOString()
  });
});

app.put('/api/orders/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Order ${req.params.id} updated`,
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.delete('/api/orders/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Order ${req.params.id} deleted`,
    timestamp: new Date().toISOString()
  });
});

// Wallet endpoints
app.get('/api/wallet', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Wallet endpoint',
    data: { balance: 0, currency: 'SAR' },
    timestamp: new Date().toISOString()
  });
});

app.post('/api/wallet/deposit', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Deposit created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.post('/api/wallet/withdraw', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Withdrawal created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

// Notifications endpoints
app.get('/api/notifications', (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Notifications endpoint',
    data: [],
    timestamp: new Date().toISOString()
  });
});

app.post('/api/notifications', (req, res) => {
  res.status(201).json({
    success: true,
    message: 'Notification created',
    data: req.body,
    timestamp: new Date().toISOString()
  });
});

app.get('/api/notifications/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Notification ${req.params.id}`,
    data: { id: req.params.id },
    timestamp: new Date().toISOString()
  });
});

app.delete('/api/notifications/:id', (req, res) => {
  res.status(200).json({
    success: true,
    message: `Notification ${req.params.id} deleted`,
    timestamp: new Date().toISOString()
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: 'Not Found',
    message: 'The requested endpoint does not exist',
    path: req.path,
    method: req.method,
    timestamp: new Date().toISOString()
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({
    success: false,
    error: 'Internal Server Error',
    message: err.message,
    timestamp: new Date().toISOString()
  });
});

// Export app for Vercel
export default app;

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on http://0.0.0.0:${PORT}`);
  console.log(`📚 API Documentation:`);
  console.log(`   - Health: http://localhost:${PORT}/api/health`);
  console.log(`   - Services: http://localhost:${PORT}/api/services`);
  console.log(`   - Products: http://localhost:${PORT}/api/products`);
  console.log(`   - Orders: http://localhost:${PORT}/api/orders`);
  console.log(`   - Wallet: http://localhost:${PORT}/api/wallet`);
  console.log(`   - Notifications: http://localhost:${PORT}/api/notifications`);
});

import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import sequelize from '../backend/models/index.js';
import Service from '../backend/models/Service.js';
import Product from '../backend/models/Product.js';
import Order from '../backend/models/Order.js';
import Wallet from '../backend/models/Wallet.js';
import Transaction from '../backend/models/Transaction.js';
import Notification from '../backend/models/Notification.js';

// Routes
import servicesRouter from '../backend/routes/services.js';
import productsRouter from '../backend/routes/products.js';
import ordersRouter from '../backend/routes/orders.js';
import walletRouter from '../backend/routes/wallet.js';
import notificationsRouter from '../backend/routes/notifications.js';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Setup associations
Product.belongsTo(Service, { foreignKey: 'serviceId' });
Service.hasMany(Product, { foreignKey: 'serviceId' });

Order.belongsTo(Product, { foreignKey: 'productId' });
Product.hasMany(Order, { foreignKey: 'productId' });

Transaction.belongsTo(Wallet, { foreignKey: 'walletId' });
Wallet.hasMany(Transaction, { foreignKey: 'walletId' });

// Routes
app.use('/api/services', servicesRouter);
app.use('/api/products', productsRouter);
app.use('/api/orders', ordersRouter);
app.use('/api/wallet', walletRouter);
app.use('/api/notifications', notificationsRouter);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'Ratlozen Backend is running',
    timestamp: new Date(),
    environment: process.env.NODE_ENV || 'development'
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

// Initialize database
let isInitialized = false;

const initializeDatabase = async () => {
  if (isInitialized) return;
  try {
    await sequelize.authenticate();
    console.log('✅ Database connection established');
    await sequelize.sync({ alter: true });
    console.log('✅ Database models synchronized');
    isInitialized = true;
  } catch (error) {
    console.error('❌ Database initialization error:', error);
  }
};

// Initialize on first request
app.use(async (req, res, next) => {
  await initializeDatabase();
  next();
});

export default app;

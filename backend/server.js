import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import sequelize from './models/index.js';
import Service from './models/Service.js';
import Product from './models/Product.js';
import Order from './models/Order.js';
import Wallet from './models/Wallet.js';
import Transaction from './models/Transaction.js';
import Notification from './models/Notification.js';

// Routes
import servicesRouter from './routes/services.js';
import productsRouter from './routes/products.js';
import ordersRouter from './routes/orders.js';
import walletRouter from './routes/wallet.js';
import notificationsRouter from './routes/notifications.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

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
  res.json({ status: 'OK', message: 'Ratlozen Backend is running' });
});

// Initialize database and start server
const startServer = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Database connection established');

    await sequelize.sync({ alter: true });
    console.log('✅ Database models synchronized');

    app.listen(PORT, () => {
      console.log(`🚀 Server running on http://localhost:${PORT}`);
      console.log(`📚 API Documentation:`);
      console.log(`   - Services: http://localhost:${PORT}/api/services`);
      console.log(`   - Products: http://localhost:${PORT}/api/products`);
      console.log(`   - Orders: http://localhost:${PORT}/api/orders`);
      console.log(`   - Wallet: http://localhost:${PORT}/api/wallet`);
      console.log(`   - Notifications: http://localhost:${PORT}/api/notifications`);
      console.log(`   - Health: http://localhost:${PORT}/api/health`);
    });
  } catch (error) {
    console.error('❌ Failed to start server:', error);
    process.exit(1);
  }
};

startServer();

export default app;

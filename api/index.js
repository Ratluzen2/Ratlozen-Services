// Simple Vercel Serverless Function Handler
export default function handler(req, res) {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Health check endpoint
  if (req.url === '/api/health' && req.method === 'GET') {
    return res.status(200).json({
      status: 'OK',
      message: 'Ratlozen Backend is running on Vercel',
      timestamp: new Date(),
      environment: process.env.NODE_ENV || 'production',
      database: process.env.DATABASE_URL ? 'Connected' : 'Not configured'
    });
  }

  // Root endpoint
  if (req.url === '/' && req.method === 'GET') {
    return res.status(200).json({
      message: 'Ratlozen Services Backend API',
      version: '1.0.0',
      endpoints: {
        health: '/api/health',
        services: '/api/services',
        products: '/api/products',
        orders: '/api/orders',
        wallet: '/api/wallet',
        notifications: '/api/notifications'
      }
    });
  }

  // Services endpoints
  if (req.url === '/api/services' && req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Services endpoint',
      data: []
    });
  }

  if (req.url === '/api/services' && req.method === 'POST') {
    return res.status(201).json({
      success: true,
      message: 'Service created',
      data: req.body
    });
  }

  // Products endpoints
  if (req.url === '/api/products' && req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Products endpoint',
      data: []
    });
  }

  if (req.url === '/api/products' && req.method === 'POST') {
    return res.status(201).json({
      success: true,
      message: 'Product created',
      data: req.body
    });
  }

  // Orders endpoints
  if (req.url === '/api/orders' && req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Orders endpoint',
      data: []
    });
  }

  if (req.url === '/api/orders' && req.method === 'POST') {
    return res.status(201).json({
      success: true,
      message: 'Order created',
      data: req.body
    });
  }

  // Wallet endpoints
  if (req.url === '/api/wallet' && req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Wallet endpoint',
      data: { balance: 0 }
    });
  }

  // Notifications endpoints
  if (req.url === '/api/notifications' && req.method === 'GET') {
    return res.status(200).json({
      success: true,
      message: 'Notifications endpoint',
      data: []
    });
  }

  // 404 Not Found
  res.status(404).json({
    error: 'Not Found',
    message: 'Endpoint not found',
    path: req.url,
    method: req.method
  });
}

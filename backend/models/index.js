import { Sequelize } from 'sequelize';

// استخدم PostgreSQL على Vercel
const databaseUrl = process.env.DATABASE_URL || 'postgresql://localhost/ratlozen';

const sequelize = new Sequelize(databaseUrl, {
  dialect: 'postgres',
  protocol: 'postgres',
  logging: process.env.NODE_ENV === 'development' ? console.log : false,
  dialectOptions: {
    ssl: process.env.NODE_ENV === 'production' ? {
      require: true,
      rejectUnauthorized: false,
    } : false,
  },
});

export default sequelize;

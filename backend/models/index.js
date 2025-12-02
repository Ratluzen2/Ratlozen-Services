import { Sequelize } from 'sequelize';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// استخدم قاعدة بيانات في الذاكرة على Vercel
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: ':memory:', // قاعدة بيانات في الذاكرة
  logging: false,
});

export default sequelize;

import { DataTypes } from 'sequelize';
import sequelize from './index.js';

const Transaction = sequelize.define('Transaction', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  walletId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'wallets',
      key: 'id',
    },
  },
  type: {
    type: DataTypes.ENUM('deposit', 'withdrawal', 'purchase', 'refund'),
    allowNull: false,
  },
  amount: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  description: {
    type: DataTypes.TEXT,
  },
}, {
  timestamps: true,
  tableName: 'transactions',
});

export default Transaction;

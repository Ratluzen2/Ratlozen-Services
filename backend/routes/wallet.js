import express from 'express';
import Wallet from '../models/Wallet.js';
import Transaction from '../models/Transaction.js';

const router = express.Router();

// Get wallet balance
router.get('/:userId', async (req, res) => {
  try {
    let wallet = await Wallet.findOne({
      where: { userId: req.params.userId },
    });

    if (!wallet) {
      wallet = await Wallet.create({
        userId: req.params.userId,
        balance: 0,
      });
    }

    res.json(wallet);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Add balance
router.post('/:userId/add', async (req, res) => {
  try {
    const { amount, description } = req.body;

    if (!amount || amount <= 0) {
      return res.status(400).json({ error: 'Invalid amount' });
    }

    let wallet = await Wallet.findOne({
      where: { userId: req.params.userId },
    });

    if (!wallet) {
      wallet = await Wallet.create({
        userId: req.params.userId,
        balance: 0,
      });
    }

    const newBalance = parseFloat(wallet.balance) + parseFloat(amount);
    await wallet.update({ balance: newBalance });

    await Transaction.create({
      walletId: wallet.id,
      type: 'deposit',
      amount,
      description,
    });

    res.json({ success: true, wallet, newBalance });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Withdraw balance
router.post('/:userId/withdraw', async (req, res) => {
  try {
    const { amount, description } = req.body;

    if (!amount || amount <= 0) {
      return res.status(400).json({ error: 'Invalid amount' });
    }

    const wallet = await Wallet.findOne({
      where: { userId: req.params.userId },
    });

    if (!wallet) {
      return res.status(404).json({ error: 'Wallet not found' });
    }

    if (parseFloat(wallet.balance) < parseFloat(amount)) {
      return res.status(400).json({ error: 'Insufficient balance' });
    }

    const newBalance = parseFloat(wallet.balance) - parseFloat(amount);
    await wallet.update({ balance: newBalance });

    await Transaction.create({
      walletId: wallet.id,
      type: 'withdrawal',
      amount,
      description,
    });

    res.json({ success: true, wallet, newBalance });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get transactions
router.get('/:userId/transactions', async (req, res) => {
  try {
    const wallet = await Wallet.findOne({
      where: { userId: req.params.userId },
    });

    if (!wallet) {
      return res.status(404).json({ error: 'Wallet not found' });
    }

    const transactions = await Transaction.findAll({
      where: { walletId: wallet.id },
      order: [['createdAt', 'DESC']],
    });

    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;

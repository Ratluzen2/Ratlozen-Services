import express from 'express';
import Notification from '../models/Notification.js';

const router = express.Router();

// Get all notifications for user
router.get('/user/:userId', async (req, res) => {
  try {
    const notifications = await Notification.findAll({
      where: { userId: req.params.userId },
      order: [['createdAt', 'DESC']],
    });
    res.json(notifications);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get unread notifications
router.get('/user/:userId/unread', async (req, res) => {
  try {
    const notifications = await Notification.findAll({
      where: { userId: req.params.userId, isRead: false },
      order: [['createdAt', 'DESC']],
    });
    res.json(notifications);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get notification by ID
router.get('/:id', async (req, res) => {
  try {
    const notification = await Notification.findByPk(req.params.id);
    if (!notification) {
      return res.status(404).json({ error: 'Notification not found' });
    }
    res.json(notification);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create notification
router.post('/', async (req, res) => {
  try {
    const { userId, title, content, type } = req.body;

    if (!userId || !title) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const notification = await Notification.create({
      userId,
      title,
      content,
      type: type || 'system',
      isRead: false,
    });

    res.status(201).json(notification);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Mark as read
router.put('/:id/read', async (req, res) => {
  try {
    const notification = await Notification.findByPk(req.params.id);
    if (!notification) {
      return res.status(404).json({ error: 'Notification not found' });
    }

    await notification.update({ isRead: true });
    res.json(notification);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete notification
router.delete('/:id', async (req, res) => {
  try {
    const notification = await Notification.findByPk(req.params.id);
    if (!notification) {
      return res.status(404).json({ error: 'Notification not found' });
    }

    await notification.destroy();
    res.json({ message: 'Notification deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;

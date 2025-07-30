const express = require('express');
const router = express.Router();
const User = require('../models/User');

// POST: Register user
router.post('/signup', async (req, res) => {
  try {
    const { name, email, password, phone, userType } = req.body;
    
    if (!name?.trim() || !email?.trim() || !password || !phone?.trim() || !userType) {
      return res.status(400).json({ error: 'All fields are required' });
    }
    
    const emailLower = email.trim().toLowerCase();
    const existingUser = await User.findOne({ email: emailLower }).lean();
    
    if (existingUser) {
      return res.status(400).json({ error: 'Email already registered' });
    }
    
    const user = new User({
      name: name.trim(),
      email: emailLower,
      password: password,
      phone: phone.trim(),
      userType: userType
    });
    
    await user.save();
    res.status(201).json({ 
      message: 'Account created successfully',
      user: { id: user._id, name: user.name, email: user.email, userType: user.userType }
    });
  } catch (err) {
    res.status(400).json({ error: 'Registration failed' });
  }
});

// POST: Login user
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    if (!email?.trim() || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }
    
    const user = await User.findOne({ 
      email: email.trim().toLowerCase(),
      password: password 
    }).lean();
    
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    res.json({
      message: 'Login successful',
      user: { id: user._id, name: user.name, email: user.email, userType: user.userType }
    });
  } catch (err) {
    res.status(500).json({ error: 'Login failed' });
  }
});

module.exports = router;
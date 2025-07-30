const express = require('express');
const router = express.Router();
const Donor = require('../models/Donor');

// GET: Fetch donors with filters
router.get('/', async (req, res) => {
  const { village, bloodGroup } = req.query;

  try {
    let query = { availability: true };
    
    if (village && village.trim()) {
      query.village = { $regex: new RegExp(village.trim(), 'i') };
    }
    
    if (bloodGroup && bloodGroup.trim()) {
      query.bloodGroup = bloodGroup.trim().toUpperCase();
    }
    
    const donors = await Donor.find(query).sort({ createdAt: -1 }).lean();
    res.json(donors);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch donors' });
  }
});

// POST: Add donor
router.post('/', async (req, res) => {
  try {
    const { name, bloodGroup, phone, village, isAvailable } = req.body;
    
    if (!name?.trim() || !bloodGroup?.trim() || !phone?.trim() || !village?.trim()) {
      return res.status(400).json({ error: 'All fields are required' });
    }
    
    const donor = new Donor({
      name: name.trim(),
      bloodGroup: bloodGroup.trim().toUpperCase(),
      phone: phone.trim(),
      village: village.trim(),
      availability: isAvailable !== false
    });
    
    await donor.save();
    res.status(201).json({ message: 'Donor registered successfully' });
  } catch (err) {
    res.status(400).json({ error: 'Failed to register donor' });
  }
});

module.exports = router;
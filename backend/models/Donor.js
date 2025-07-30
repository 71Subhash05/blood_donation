const mongoose = require('mongoose');

const DonorSchema = new mongoose.Schema({
  name: { type: String, required: true },
  bloodGroup: { type: String, required: true },
  phone: { type: String, required: true },
  village: { type: String, required: true },
  availability: { type: Boolean, default: true }
}, {
  timestamps: true
});

module.exports = mongoose.model('Donor', DonorSchema);
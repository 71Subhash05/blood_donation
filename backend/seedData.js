const mongoose = require('mongoose');
require('dotenv').config();
const Donor = require('./models/Donor');

const sampleDonors = [
  {
    name: "Ravi Kumar",
    bloodGroup: "O+",
    phone: "9876543210",
    village: "Avanigadda",
    availability: true
  },
  {
    name: "Priya Sharma",
    bloodGroup: "A+",
    phone: "9876543211",
    village: "Vijayawada",
    availability: true
  },
  {
    name: "Suresh Reddy",
    bloodGroup: "B+",
    phone: "9876543212",
    village: "Avanigadda",
    availability: false
  },
  {
    name: "Lakshmi Devi",
    bloodGroup: "AB+",
    phone: "9876543213",
    village: "Guntur",
    availability: true
  },
  {
    name: "Venkat Rao",
    bloodGroup: "O-",
    phone: "9876543214",
    village: "Avanigadda",
    availability: true
  }
];

async function seedDatabase() {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ Connected to MongoDB');
    
    await Donor.deleteMany({});
    await Donor.insertMany(sampleDonors);
    console.log('✅ Sample donors added');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

seedDatabase();
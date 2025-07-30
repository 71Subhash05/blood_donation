const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json({ limit: '10mb' }));

mongoose.connect(process.env.MONGO_URI)
.then(() => console.log('✅ MongoDB connected'))
.catch(() => console.log('❌ MongoDB connection failed - using fallback'));

app.use('/api/donors', require('./routes/donors'));
app.use('/api/auth', require('./routes/auth'));

app.get('/', (req, res) => res.send('🩸 Blood Donation API'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server: http://localhost:${PORT}`));
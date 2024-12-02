const express = require('express');
require('dotenv').config();
const mongoose = require('mongoose');
const cors = require('cors');
const foodRoutes = require('./routes/foodRoutes');
const cartRoutes = require('./routes/cartRoutes');

// Initialize the app
const app = express();
app.use(cors());
app.use(express.json());  // Parse JSON bodies
app.use('/api/food', foodRoutes);
app.use('/api/cart', cartRoutes);

// Serve static files (like images)
app.use('/uploads', express.static('uploads'));

// Ensure the 'uploads' folder exists
const fs = require('fs');
const uploadDir = './uploads';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// MongoDB connection
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('Connected to MongoDB Atlas'))
  .catch(err => console.error('Error connecting to MongoDB:', err));

// Start the server
const port = 5000;
app.listen(port, '0.0.0.0',() => {
  console.log(`Server is running on http://localhost:${port}`);
});

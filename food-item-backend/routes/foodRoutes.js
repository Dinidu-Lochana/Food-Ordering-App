const express = require('express');
const multer = require('multer');
const path = require('path');
const Food = require('../models/FoodItem');  // Food model
const fs = require('fs');
const router = express.Router();

// Ensure the 'uploads' folder exists
const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// Set up multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, './uploads');  // Specify the folder where the image will be stored
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));  // Generate a unique file name
  },
});

const upload = multer({ storage: storage });

// Route to handle adding food item along with an image
router.post('/addFoodItem', upload.single('image'), async (req, res) => {
  console.log(req.body);  // Log form fields
  console.log(req.file);  // Log uploaded file info

  const { name, type, description, amount } = req.body;
  const imageUrl = req.file ? `http://localhost:5000/uploads/${req.file.filename}` : null;

  if (!name || !type || !description || !amount || !imageUrl) {
    return res.status(400).json({ message: 'All fields are required, including the image.' });
  }

  try {
    const newFoodItem = new Food({
      name,
      type,
      description,
      amount,
      imageUrl,
    });

    await newFoodItem.save();
    res.status(200).json({ message: 'Food item added successfully!' });
  } catch (err) {
    console.error('Error saving food item:', err);
    res.status(500).json({ message: 'Failed to add food item.' });
  }
});

module.exports = router;

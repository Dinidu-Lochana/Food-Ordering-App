const express = require('express');
const multer = require('multer');
const path = require('path');
const Food = require('../models/FoodItem');
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
  const imageUrl = req.file ? `http://192.168.8.170:5000/uploads/${req.file.filename}` : null;

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

// Route to get all food items
router.get('/getFoodItems', async (req, res) => {
  try {
    const foodItems = await Food.find();  // Get all food items from the database

    if (!foodItems.length) {
      return res.status(404).json({ message: 'No food items found.' });
    }

    res.status(200).json(foodItems);  // Return the list of all food items
  } catch (err) {
    console.error('Error fetching food items:', err);
    res.status(500).json({ message: 'Failed to fetch food items.' });
  }
});

// Route to get a food item by ID
router.get('/getFoodItem/:id', async (req, res) => {
  try {
    const foodItem = await Food.findById(req.params.id);

    if (!foodItem) {
      return res.status(404).json({ message: 'Food item not found.' });
    }

    res.status(200).json(foodItem);  // Return the food item details
  } catch (err) {
    console.error('Error fetching food item:', err);
    res.status(500).json({ message: 'Failed to fetch food item.' });
  }
});

// Route to update a food item by ID
router.put('/updateFoodItem/:id', upload.single('image'), async (req, res) => {
  const { name, type, description, amount } = req.body;
  let imageUrl = req.file ? `http://localhost:5000/uploads/${req.file.filename}` : null;

  try {
    const foodItem = await Food.findById(req.params.id);

    if (!foodItem) {
      return res.status(404).json({ message: 'Food item not found.' });
    }

    // Update food item details
    foodItem.name = name || foodItem.name;
    foodItem.type = type || foodItem.type;
    foodItem.description = description || foodItem.description;
    foodItem.amount = amount || foodItem.amount;
    foodItem.imageUrl = imageUrl || foodItem.imageUrl;

    await foodItem.save();
    res.status(200).json({ message: 'Food item updated successfully!' });
  } catch (err) {
    console.error('Error updating food item:', err);
    res.status(500).json({ message: 'Failed to update food item.' });
  }
});

// Route to delete a food item by ID
router.delete('/deleteFoodItem/:id', async (req, res) => {
  try {
    const foodItem = await Food.findByIdAndDelete(req.params.id);

    if (!foodItem) {
      return res.status(404).json({ message: 'Food item not found.' });
    }

    res.status(200).json({ message: 'Food item deleted successfully!' });
  } catch (err) {
    console.error('Error deleting food item:', err);
    res.status(500).json({ message: 'Failed to delete food item.' });
  }
});

module.exports = router;

const express = require('express');
const Cart = require('../models/CartSchema');
const Food = require('../models/FoodItem');
const router = express.Router();

// Add to Cart
// router.post('/addToCart', async (req, res) => {
//     try {
//         const { userId, foodItemId, quantity } = req.body;

//         if (!userId || !foodItemId || !quantity) {
//             return res.status(400).json({ error: 'Missing required fields' });
//         }

//         const newCartItem = new Cart({ userId, foodItemId, quantity });
//         await newCartItem.save();

//         // Use 200 instead of 201 to avoid issues with frontend
//         res.status(200).json({ message: 'Item added to cart successfully', cartItem: newCartItem });
//     } catch (error) {
//         console.error('Error adding to cart:', error);
//         res.status(500).json({ error: 'Internal Server Error' });
//     }
// });

// Add to Cart
router.post('/addToCart', async (req, res) => {
  try {
      const { userId, foodItemId, quantity } = req.body;

      if (!userId || !foodItemId || !quantity) {
          return res.status(400).json({ error: 'Missing required fields' });
      }

      let cart = await Cart.findOne({ userId });

      if (!cart) {
          // If no cart exists, create a new one
          cart = new Cart({ userId, items: [] });
      }

      const existingItemIndex = cart.items.findIndex(item => item.foodItemId.toString() === foodItemId);

      if (existingItemIndex > -1) {
          // Update the quantity if the item already exists in the cart
          cart.items[existingItemIndex].quantity += quantity;
      } else {
          // Add a new item to the cart if not already present
          const newCartItem = { foodItemId, quantity };
          cart.items.push(newCartItem);
      }

      await cart.save();
      res.status(200).json({ message: 'Item added to cart successfully', cart });
  } catch (error) {
      console.error('Error adding to cart:', error);
      res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Update Cart Item
router.put('/updateCartItem', async (req, res) => {
    const { userId, foodItemId, quantity } = req.body;
  
    if (!userId || !foodItemId || quantity == null) {
      return res.status(400).json({ message: 'User ID, Food Item ID, and Quantity are required.' });
    }
  
    try {
      const cart = await Cart.findOne({ userId });
  
      if (!cart) {
        return res.status(404).json({ message: 'Cart not found.' });
      }
  
      const item = cart.items.find(item => item.foodItemId.toString() === foodItemId);
  
      if (item) {
        item.quantity = quantity;
        await cart.save();
        res.status(200).json({ message: 'Cart item updated successfully!', cart });
      } else {
        res.status(404).json({ message: 'Item not found in cart.' });
      }
    } catch (err) {
      console.error('Error updating item:', err);
      res.status(500).json({ message: 'Failed to update item.' });
    }
  });
  
// Get Cart

// Get Cart
router.get('/getCart/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
      const cart = await Cart.findOne({ userId }).populate('items.foodItemId');  // Populating the foodItemId field

      if (!cart) {
          return res.status(404).json({ message: 'Cart not found.' });
      }

      res.status(200).json(cart);
  } catch (err) {
      console.error('Error fetching cart:', err);
      res.status(500).json({ message: 'Failed to fetch cart.' });
  }
});


// Remove Item from Cart
router.delete('/removeFromCart', async (req, res) => {
  const { userId, foodItemId } = req.body;

  if (!userId || !foodItemId) {
    return res.status(400).json({ message: 'User ID and Food Item ID are required.' });
  }

  try {
    const cart = await Cart.findOne({ userId });

    if (!cart) {
      return res.status(404).json({ message: 'Cart not found.' });
    }

    cart.items = cart.items.filter(item => item.foodItemId.toString() !== foodItemId);
    await cart.save();

    res.status(200).json({ message: 'Item removed from cart successfully!', cart });
  } catch (err) {
    console.error('Error removing item from cart:', err);
    res.status(500).json({ message: 'Failed to remove item from cart.' });
  }
});

module.exports = router;

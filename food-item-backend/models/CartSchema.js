const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CartItemSchema = new Schema({
  foodItemId: { type: mongoose.Schema.Types.ObjectId, ref: 'Food' },
  quantity: { type: Number, required: true },
});

const CartSchema = new Schema({
  userId: { type: String, required: true },
  items: [CartItemSchema],
});

const Cart = mongoose.model('Cart', CartSchema);
module.exports = Cart;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_order_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;

  Cart? get cart => _cart;

 Future<void> fetchCart(String userId) async {
  final response = await http.get(
    Uri.parse('http://192.168.8.170:5000/api/cart/getCart/$userId'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Cart Data: $data');  // Debug print to log the response

    _cart = Cart(
      userId: data['userId'],
      items: (data['items'] as List).map((item) {
        print('Food Item: ${item['foodItemId']}');  // Debug print to log the foodItemId
        return CartItem(
          id: item['_id'],
          foodItemId: item['foodItemId']['_id'],
          foodName: item['foodItemId']['name'],
          quantity: item['quantity'],
          price: item['foodItemId']['price'],
        );
      }).toList(),
    );
    print('Cart Items: ${_cart?.items}');  // Debug print to log cart items
    notifyListeners();
  } else {
    throw Exception('Failed to load cart');
  }
}

  Future<void> addToCart(String userId, String foodItemId, int quantity) async {
    final response = await http.post(
      Uri.parse('http://192.168.8.170:5000/api/cart/addToCart'),
      body: json.encode({
        'userId': userId,
        'foodItemId': foodItemId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      fetchCart(userId); // Reload the cart
    } else {
      throw Exception('Failed to add item to cart');
    }
  }

  Future<void> updateCartItem(String userId, String foodItemId, int quantity) async {
    final response = await http.put(
      Uri.parse('http://192.168.8.170:5000/api/cart/updateCartItem'),
      body: json.encode({
        'userId': userId,
        'foodItemId': foodItemId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      fetchCart(userId); // Reload the cart
    } else {
      throw Exception('Failed to update cart item');
    }
  }

  Future<void> removeFromCart(String userId, String foodItemId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.8.170:5000/api/cart/removeFromCart'),
      body: json.encode({
        'userId': userId,
        'foodItemId': foodItemId,
      }),
    );

    if (response.statusCode == 200) {
      fetchCart(userId); // Reload the cart
    } else {
      throw Exception('Failed to remove item from cart');
    }
  }
}

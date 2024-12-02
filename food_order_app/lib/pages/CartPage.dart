import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_order_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        if (cartProvider.cart == null) {
          return Center(child: CircularProgressIndicator());  // Show loading if cart is null
        }

        if (cartProvider.cart!.items.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User ID: ${cartProvider.cart!.userId}'),  // Display the userId
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cart!.items.length,
                itemBuilder: (context, index) {
                  final cartItem = cartProvider.cart!.items[index];
                  return ListTile(
                    title: Text(cartItem.foodName),
                    subtitle: Text('Quantity: ${cartItem.quantity}'),
                    trailing: Text('Price: \$${cartItem.price}'),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}


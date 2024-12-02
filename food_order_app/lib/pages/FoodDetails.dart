import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  final Map item;

  const FoodDetails({super.key, required this.item});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double price = (widget.item['amount'] as num).toDouble() * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.item['imageUrl'], height: 200),
            ),
            SizedBox(height: 16),
            Text(widget.item['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.item['description'], style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quantity:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(quantity.toString(), style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Total: \$${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                addToCart(widget.item, quantity);
              },
              child: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(Map item, int quantity) {
    print('Added to cart: ${item['name']} (x$quantity)');
    Navigator.pop(context);
  }
}

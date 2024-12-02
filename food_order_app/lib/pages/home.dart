import 'package:flutter/material.dart';
import 'package:food_order_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool rice = false, burger = false, beverages = false, dessert = false;

  // Example food data for each category
  List<String> riceItems = ["Fried Rice", "Chicken Rice", "Veg Rice"];
  List<String> burgerItems = ["Cheese Burger", "Veg Burger", "Chicken Burger"];
  List<String> beverageItems = ["Coke", "Juice", "Water"];
  List<String> dessertItems = ["Cake", "Ice Cream", "Brownie"];

  List<String> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = riceItems; // Initially, show rice items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 55, left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("WELCOME TO URBANFOOD,", style: AppWidget.boldTextFieldStyle()),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Text("Choose the Best", style: AppWidget.headLineTextFieldStyle()),
            Text("Discover and get Great Food", style: AppWidget.LightTextFieldStyle()),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rice Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rice = true;
                      burger = false;
                      beverages = false;
                      dessert = false;
                      displayedItems = riceItems; // Show rice items
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: rice ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/pngwing.com (2).png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        color: rice ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                // Burger Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rice = false;
                      burger = true;
                      beverages = false;
                      dessert = false;
                      displayedItems = burgerItems; // Show burger items
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/burger-logo-icon_567288-500-removebg-preview.png",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Beverages Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rice = false;
                      burger = false;
                      beverages = true;
                      dessert = false;
                      displayedItems = beverageItems; // Show beverage items
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/pngegg (7).png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Desserts Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rice = false;
                      burger = false;
                      beverages = false;
                      dessert = true;
                      displayedItems = dessertItems; // Show dessert items
                    });
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/pngwing.com (3).png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display filtered items based on selected category
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(displayedItems[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

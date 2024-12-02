import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/auth_pages/login.dart'; // Import your login page here
import 'FoodDetails.dart';
import 'CartPage.dart'; // Import your Cart page here
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = ''; // Track the selected category
  List foodItems = [];
  List displayedItems = [];
  List cartItems = []; // List to track items in the cart
  late String userId;

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
    getUserId();
  }

void getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid; // Store user ID
      });
    }
  }
  Future<void> fetchFoodItems() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.8.170:5000/api/food/getFoodItems'));

      if (response.statusCode == 200) {
        final List fetchedItems = json.decode(response.body);
        setState(() {
          foodItems = fetchedItems;
          displayedItems = fetchedItems;
        });
      } else {
        throw Exception('Failed to load food items');
      }
    } catch (error) {
      print('Error fetching food items: $error');
    }
  }

  void filterItems(String category) {
    setState(() {
      selectedCategory = category; // Update the selected category
      displayedItems = foodItems.where((item) {
        return item['type'].toLowerCase() == category.toLowerCase();
      }).toList();
    });
  }

  void logout() {
    // Clear session data, if any
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void addToCart(Map item) {
    setState(() {
      cartItems.add(item); // Add selected item to the cart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UrbanFood"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            tooltip: 'View Cart',
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("WELCOME TO URBANFOOD,", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text("Choose the Best", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text("Discover and get Great Food", style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCategoryButton('rice', "images/pngwing.com (2).png"),
                buildCategoryButton('burger', "images/burger-logo-icon_567288-500-removebg-preview.png"),
                buildCategoryButton('beverages', "images/pngegg (7).png"),
                buildCategoryButton('dessert', "images/pngwing.com (3).png"),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final item = displayedItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetails(item: {
                            ...item,
                            'amount': (item['amount'] as num).toDouble(),
                          }),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.network(item['imageUrl'], height: 50, width: 50),
                        title: Text(item['name']),
                        subtitle: Text(item['description']),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("\$${item['amount']}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                            SizedBox(height: 5),
                            
                          ],
                        ),
                      ),
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

  Widget buildCategoryButton(String category, String imagePath) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () => filterItems(category),
      child: Material(
        elevation: isSelected ? 10.0 : 5.0,
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Colors.orange : Colors.white, // Change color if selected
        child: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            imagePath,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            color: isSelected ? Colors.white : Colors.black, // Change icon color if selected
          ),
        ),
      ),
    );
  }
}

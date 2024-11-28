import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/pages/auth_pages/login.dart';
import 'package:food_order_app/pages/auth_pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/login', // Set the initial page
      routes: {
        '/login': (context) => LoginPage(), // Login page route
        '/signup': (context) => SignUpPage(), // Sign-Up page route
      },
    );
  }
}

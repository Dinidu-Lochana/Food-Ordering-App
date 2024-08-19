import 'package:flutter/material.dart';
import 'package:food_order_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container
      ( margin: EdgeInsets.only(top: 55, left: 15,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Hello Dinidu,", style: AppWidget.boldTextFieldStyle()),

        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
        )],
          ),
          SizedBox(height: 25.0,),
          Text("Choose the Best", style: AppWidget.headLineTextFieldStyle()),
          Text("Discover and get Great Food", style: AppWidget.LightTextFieldStyle()),
          Row(children: [
            Container(
              child: Image.asset("images/pngwing.com (2).png",height: 40,width: 40, fit: BoxFit.cover,),
            )
          ],)
      ],
      ),)
    );
  }
}  
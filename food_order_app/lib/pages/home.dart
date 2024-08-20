import 'package:flutter/material.dart';
import 'package:food_order_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool rice=false, burger=false, beverages = false, dessert=false;

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
          child: Icon(Icons.shopping_cart_outlined, color: Colors.white, ),
        )],
          ),
          SizedBox(height: 25.0,),
          Text("Choose the Best", style: AppWidget.headLineTextFieldStyle()),
          Text("Discover and get Great Food", style: AppWidget.LightTextFieldStyle()),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  rice = true;
                  burger = false;
                  beverages=false;
                  dessert=false;
                  setState(() {
                    
                  });
                },
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child:Container(
                    decoration: BoxDecoration(color: rice?Colors.black:Colors.white,borderRadius: BorderRadius.circular(10)),
                    padding:EdgeInsets.all(10) ,
                    child: Image.asset("images/pngwing.com (2).png",height: 50,width: 50, fit: BoxFit.cover, color: rice? Colors.white: Colors.black,),
            ) ,
            ),
            ),
            
           

            Material(elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child:Container(
              padding:EdgeInsets.all(10) ,
              child: Image.asset("images/burger-logo-icon_567288-500-removebg-preview.png",height: 60,width: 60, fit: BoxFit.cover,),
            ) ,),

            Material(elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child:Container(
              padding:EdgeInsets.all(10) ,
              child: Image.asset("images/pngegg (7).png",height: 50,width: 50, fit: BoxFit.cover,),
            ) ,),

            Material(elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child:Container(
              padding:EdgeInsets.all(10) ,
              child: Image.asset("images/pngwing.com (3).png",height: 50,width: 50, fit: BoxFit.cover,),
            ) ,),
            
          ],)
      ],
      ),)
    );
  }
}  
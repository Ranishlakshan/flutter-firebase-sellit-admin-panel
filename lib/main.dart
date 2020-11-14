import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_admin/checkout.dart';
import 'package:sell_admin/mynewpg.dart';
import 'package:sell_admin/productModel.dart';
import 'package:sell_admin/productsc.dart';

import 'addhotdeal.dart';
import 'allads.dart';
import 'carosalImages.dart';
import 'cartItemCounter.dart';
import 'firstpage.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'maincarosalview.dart';
import 'oldads.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (c) => CartItemCounter()),
          ChangeNotifierProvider(create: (c) => CartItemCounter()),
          ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: FirstPage(),
        home: FirstPage(),
        //home: CartApp(),
        routes: {
          '/reviewpage': (context) => HomePage(),
          //AllAds
          '/allads': (context) => AllAds(),
          //OldAds
          '/oldads': (context) => OldAds(),
          //carosalImages CarosalImages
          '/carosalImages': (context) => CarosalImages(),
          //MainCarosalView
          '/maincarosalview': (context) => MainCarosalView(),
          //AddHotDeal
          '/addhotdeal': (context) => AddHotDeal(),
          //LoginPage
          '/loginpage': (context) => LoginPage(),
          //PayHere
          //'/payhere': (context) => PayHere(),
          //mynewpg
          '/mynewpg': (context) => MyNewPage(),
        },
      ),
    );
  }
}

class CartApp extends StatefulWidget {
  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  List<ProductModel> cart = [];
  int sum = 0;
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart App"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Products",),
              Tab(text: "Checkout",),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                //Navigator.push(cont);
                //addDialog(context);
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ProductScreen((selectedProduct){
              setState(() {
                cart.add(selectedProduct);//update
                sum = 0;
                cart.forEach((item){
                  sum = sum + item.price;
                });
              });
            }),
            CheckoutScreen(cart, sum),
          ],
        ),
      ),
    );
  }
}




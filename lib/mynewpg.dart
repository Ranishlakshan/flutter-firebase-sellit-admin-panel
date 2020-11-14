import 'package:flutter/material.dart';

class MyNewPage extends StatefulWidget {
  @override
  _MyNewPageState createState() => _MyNewPageState();
}

class _MyNewPageState extends State<MyNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My New Page "),
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
      body: ListView(
        children: <Widget>[
          Text("Hi ranish")
        ],
      ),
      
    );
  }
}
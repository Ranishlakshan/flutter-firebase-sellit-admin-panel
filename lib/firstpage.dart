import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


//var locationsnap = Firestore.instance.collection("search_location").snapshots();

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height:25),
          RaisedButton(
            child: Text("Review"),
            onPressed: (){
              Navigator.pushNamed(context, "/reviewpage");
            },
          ),
          SizedBox(height:25),
          RaisedButton(
            child: Text("All Ads"),
            onPressed: (){
              Navigator.pushNamed(context, "/allads");
            },
          ),
          SizedBox(height:25),
          RaisedButton(
            child: Text("Old Ads"),
            onPressed: (){
              Navigator.pushNamed(context, "/oldads");
            },
          ),

        ],
      ),
    );
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainCarosalView extends StatefulWidget {
  @override
  _MainCarosalViewState createState() => _MainCarosalViewState();
}

class _MainCarosalViewState extends State<MainCarosalView> {
  
  var cars_img;
  List<String> _listOfImages = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    
    cars_img = Firestore.instance
        .collection('maincarosal')
        .document('imageset')
        .snapshots();
        
    super.initState();


  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Carosal View"),

      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
                stream: cars_img,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //title = snapshot.data['value1'];
                    //setState(() { title = snapshot.data['value1']; });
                    _listOfImages = [];
                    for (int i = 0; i < snapshot.data['urls'].length; i++) {
                      _listOfImages.add(snapshot.data['urls'][i]);
                    }
                  }
                  return CarouselSlider(
                      items: _listOfImages.map((e){
                        return ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 200.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                  //image appear in correct width and height
                                  //child: Image.network(e, fit: BoxFit.fill),
                                  child: Image.network(e),
                                  
                                  ),
                            ));
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ));
                }
                ),
        ],
      ),
      
    );
  }
}
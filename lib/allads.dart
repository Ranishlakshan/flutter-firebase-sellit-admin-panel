import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dbmodels/add_card_gridview.dart';
import 'dbmodels/car_itm_model.dart';

//var adsall = Firestore.instance.collection("ads").snapshots();
String count;


class AllAds extends StatefulWidget {
  @override
  _AllAdsState createState() => _AllAdsState();
}

class _AllAdsState extends State<AllAds> {
  
  CarModel carObjec = new CarModel("","","","","","");
  var car;
  List<CarModel> _listOfObjects = <CarModel>[];


  @override
  void initState() {
    // TODO: implement initState
    carObjec.getAllData().then((result) {
      setState(() {
        car = result;
      });
    });
    super.initState();
    //print();
  }

  @override
  Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _listOfObjects.length, //staticData.length,
  
      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_listOfObjects[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Ads ( ${count} )"),
      ),
      body: ListView(
        children: <Widget>[
          Text("Ranish"),
          StreamBuilder(
            stream: car,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                
                _listOfObjects = <CarModel>[];
                  count = snapshot.data.documents.length.toString();
                 for (int i = 0; i < snapshot.data.documents.length; i++) {
                  // DocumentSnapshot snap = snapshot.data.documents[i];
                  
                    String docID = snapshot.data.documents[i].documentID;
                    String value1 =snapshot.data.documents[i].data['value1'];
                    String value2 = snapshot.data.documents[i].data['value2'];
                    String value3 = snapshot.data.documents[i].data['value3'];
                    String value4 = snapshot.data.documents[i].data['value4'];
                    String carimage =
                        snapshot.data.documents[i].data['urls'][0];                  
                    _listOfObjects.add(CarModel(value1,value2,value3,value4,carimage,docID));
                  
                  
                  
                }
                return sliverGridWidget(context); 
              }else{
                return Text("loading");
              }
                 
                 
              },
          ),


        ],
      ),
    );
  }
}
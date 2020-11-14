import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'zoomImage.dart';



class ItemView extends StatefulWidget {
  final String docID123;

  const ItemView({ this.docID123}) ;

  @override
  _ItemViewState createState() => _ItemViewState();
}
String name123;
var cars;
var cars_img;

String title = '';
String price = '';
String phone = '';

String serchText=' ';

//final String number = "123456789";
//final String email = "dancamdev@example.com";
String numb;
String desc;

class _ItemViewState extends State<ItemView> {
  @override
  //String docuID = Widget.documentid;
  
  List<String> _listOfImages = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
        
    super.initState();

    cars_img = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
        
    super.initState();


  }

  

  Widget build(BuildContext context) {
    //final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    //docID = ${rcvdData['docuID'];}
    //String name123  = rcvdData[0];
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Data'),
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
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ZoomImage(zoomlistOfImages: _listOfImages),
                                      ),
                                    );
                                  }),
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
          Text(' -------------- '),
          //Text(title),
          getTitle(),
          //getMain(),
          Text(' -------------- '),
          getItems(),
          SizedBox(height:35),
          Text(' --- START --- '),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          //Text('Nimasha'),
          
          getRow(),

          //Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          //  children: <Widget>[
          //    RaisedButton(
          //    child: Text(
          //      "call $number",
          //    ),
          //    onPressed: () {
          //      launch("tel:$number");
          //    }
          //  ),
          //  SizedBox(width: 40.0,),
          //  RaisedButton(
          //    child: Text(
          //      "message $number",
          //    ),
          //    onPressed: () {
          //      launch("sms:$number");
          //    },
          //  ),
          //
          //
          //  ],
          //),
          RaisedButton(
            child: Text("press me"),
            onPressed: (){
              
            },
          ),
          Text(' --- END --- '),
          Text(serchText),
          RaisedButton(
            child: Text("DELETE AD"),
            onPressed: (){
              print("Deleted");
              Firestore.instance.collection('ads').document('${widget.docID123}').delete();

              Navigator.pop(context);
            },
          ),
          RaisedButton(
            child: Text("APPROVE"),
            onPressed: (){
              print("REVIEWED");
              Firestore.instance.collection('ads').document('${widget.docID123}')
              .updateData({"reviewstatus":true});
              Navigator.pop(context);
            },
          ),
          
        ],
      )
    );
  }
}

Widget getMain(){
  return StreamBuilder(
    stream: cars_img,
    builder: (context, snapshot1) {
      if (!snapshot1.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title1 = snapshot1.data;

        String tijsonString = title1.data.toString();
        return Text(tijsonString);
      },
  );
}

Widget getRow(){
  return StreamBuilder(
    stream: cars,
    builder: (context, snapshot) {
         if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title2 = snapshot.data;

        String phonetijsonString = title2.data.toString();
        String tistart = "[";
        String tiend = "]";
        final phonetistartIndex = phonetijsonString.indexOf(tistart);
        final phonetiendIndex = phonetijsonString.indexOf(tiend, phonetistartIndex + tistart.length);
        String phonetinext = phonetijsonString.substring(phonetistartIndex + tistart.length, phonetiendIndex);
        String phonetiimagelinkRemoved = phonetijsonString.replaceAll(phonetinext, "");
        String phonetiurlremoved = phonetiimagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> phonetiviewList =[]; 
        List<String> phonetispec_list = phonetiurlremoved.split(", ");
        
        for(int j=0;j<phonetispec_list.length;j++){
          if( phonetispec_list[j].contains('phone') ){
              String phoneremovevalue1 = phonetispec_list[j].replaceAll("phone:", "");
              //title = phoneremovevalue1;
              numb = phoneremovevalue1;

              //tiviewList.add(tispec_list[j]);
              //print(title);
          }
          else if(phonetispec_list[j].contains('description')){
             desc = phonetispec_list[j].replaceAll("description:", "");

          }
        }
        //return Text(title + price);
        //return Text(numb);
        return Column(
          children: <Widget>[
            Text(desc,style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
              color: Colors.blueAccent,
              highlightColor: Colors.lightBlue,
              child: Text(
                "call $numb",
              ),
              onPressed: () {
                launch("tel:$numb");
              }
            ),
            SizedBox(width: 40.0,),
            RaisedButton(
              color: Colors.blueAccent,
              highlightColor: Colors.lightBlue,
              child: Text(
                "message $numb",
              ),
              onPressed: () {
                launch("sms:$numb");
              },
            ),


            ],
          )
          ],
        );

        
        
        
      },
    
  );
}

Widget getTitle(){
    return StreamBuilder(
      stream: cars,
      builder: (context, snapshot) {
         if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title1 = snapshot.data;

        String tijsonString = title1.data.toString();
        String tistart = "[";
        String tiend = "]";
        final tistartIndex = tijsonString.indexOf(tistart);
        final tiendIndex = tijsonString.indexOf(tiend, tistartIndex + tistart.length);
        String tinext = tijsonString.substring(tistartIndex + tistart.length, tiendIndex);
        String tiimagelinkRemoved = tijsonString.replaceAll(tinext, "");
        String tiurlremoved = tiimagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> tiviewList =[]; 
        List<String> tispec_list = tiurlremoved.split(", ");
        
        for(int j=0;j<tispec_list.length;j++){
          if( tispec_list[j].contains('value1') ){
              String removevalue1 = tispec_list[j].replaceAll("value1:", "");
              title = removevalue1;
              //tiviewList.add(tispec_list[j]);
              //print(title);
          }
          else if( tispec_list[j].contains('value2') ){
              String removevalue2 = tispec_list[j].replaceAll("value2:", "");
              price = removevalue2;
              //tiviewList.add(tispec_list[j]);
              //print(price);
          }
          //else if( tispec_list[j].contains('phone') ){
          //    String removevalue3 = tispec_list[j].replaceAll("phone:", "");
          //    phone = removevalue3;
          //    //tiviewList.add(tispec_list[j]);
          //    //print(price);
          //}

        }
        //return Text(title + price);
        return Column(
          children: <Widget>[
            Text(title.toUpperCase(),
              style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )
              ),
            Text("Rs ${price}",
              style: new  TextStyle(fontSize: 26,background: Paint()
                    ..strokeWidth = 6.0
                    ..color = Colors.yellow
                    ..style = PaintingStyle.fill
                    ..strokeJoin = StrokeJoin.round
                    )
            ),
          ],
        );
        int tiviewlistlen = tiviewList.length;
        
        /////
        //return ListView.builder(
        //        shrinkWrap: true,
        //        primary: false,
        //        itemCount: tiviewlistlen,
        //        itemBuilder: (context,index){
        //          return Card(
        //            //child: Text(spec_list[index])
        //            child: Column(
        //              children: <Widget>[
        //                Text(tiviewList[index]),
        //                
        //              ],
        //            ),
        //            );
        //        },            
        //);
        /////
      },
    );
}

Widget getItems(){
    return StreamBuilder(
      //1597917013710
      //stream: Firestore.instance.collection('ads').document('1597917013710').snapshots(),
      stream: cars,
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot dd = snapshot.data; 

        //
      
        //
        var userDocument = snapshot.data;
        //String myname = dd.data.toString();
        int len = dd.data.length;
        
        String jsonString = dd.data.toString();
        String start = "[";
        String end = "]";
        final startIndex = jsonString.indexOf(start);
        final endIndex = jsonString.indexOf(end, startIndex + start.length);
        String next = jsonString.substring(startIndex + start.length, endIndex);
        String imagelinkRemoved = jsonString.replaceAll(next, "");
        String urlremoved = imagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> viewList =[]; 
        List<String> spec_list = urlremoved.split(", ");
        
        

        for(int j=0;j<spec_list.length;j++){

          if(!(spec_list[j].contains('value') || spec_list[j].contains('searchkey')  || spec_list[j].contains('reviewstatus') || spec_list[j].contains('description')) ){
            viewList.add(spec_list[j]);
          }
          
        }
        
        int speclistlen = spec_list.length;
        int viewlistlen = viewList.length;
        //
        return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: viewlistlen,
                itemBuilder: (context,index){
                  //return Card(
                  //  //child: Text(spec_list[index])
                  //  child: Column(
                  //    children: <Widget>[
                  //      Text(viewList[index]),
                  //      
                  //    ],
                  //  ),
                  //  );
                  return ( 
                    Text("     " + viewList[index],style: TextStyle(color: Colors.brown,fontSize: 18,),)
                    
                  );
                },
              
        );

        //int i=0;
        //if(i<speclistlen){
        //  return Text (spec_list[i]);
        //} 
        //return Text(speclistlen.toString());
        //for(int i;i<5;i++){
        //  return Text(spec_list[i]);
        //}
        //List<String> items = ;
        //return new Text(list[9]);
        //return new Text(spec_list[9]);
        //return ListView(
        //  
        //  children: <Widget>[
        //    
        //  ],
        //);
      }
    );
}


Future getCatagory() async {
      var firestone = Firestore.instance;

      QuerySnapshot alldata = await firestone.collection("catagory_names/Vehicles").getDocuments();
      for(int i=0;i<alldata.documents.length;i++){
                        DocumentSnapshot snap = alldata.documents[i];
                        
                      }

      return  Text('12345');

    }
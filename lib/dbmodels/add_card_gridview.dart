import 'package:flutter/material.dart';
//import 'package:progressive_image/progressive_image.dart';


import '../itemview.dart';
import 'car_itm_model.dart';



class AadCardForGrid extends StatelessWidget {

  AadCardForGrid(this.ad);
  String documentid;
  CarModel ad;

  //var name1;

  //String name1 = ad.docID.toString();
  Widget _buildImageWidget() {
    //documentid = ad.docID;
    if (ad.carimage != null && ad.carimage != '') {
      //return Image.network(ad.carimage);
      return Stack(
        children: <Widget>[
          Image.network(ad.carimage),
          
          //Center(child: Text(ad.value2,textDirection: ,),)
          //Card(
          //  child: Text("Rs "+ad.value2),
          //  color: Colors.yellow,
          //  margin: EdgeInsets.all(10),
          //  
          //  //shape: CircleBorder(),  
          //),
        ],
      );
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
    }
    
  }
  Widget _buildTitleWidget() {

    if (ad.value1 != null && ad.value1 != '') {
      return Text(ad.value1, style: TextStyle(fontWeight: FontWeight.bold),);
    } else {
      return SizedBox();
    }
  }

  Widget _buildPriceWidget() {
    if (ad.value2 != null && ad.value2 != '') {
      return Text("\Rs ${ad.value2}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildTimeWidget() {
    if (ad.value4 != null && ad.value4 != '') {
      return Text(" ${ad.value4}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildLocationWidget() {
    if (ad.value3 != null && ad.value3 != '') {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(width: 4.0,),
          Expanded(child: Text(ad.value3))
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemView(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageWidget(),
          //_buildTitleWidget(),
          //SizedBox(height: 5,),
          //_buildPriceWidget(),
          //
          //_buildLocationWidget(),
          //Container(
          //  alignment: Alignment.bottomRight,
          //  child: _buildTimeWidget(),
          //),
          SizedBox(height: 5,),  
          Text('  ${ad.value1}'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(height: 2,),
          //Text('  Rs ${ad.value2}'),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Card(
            child: Text(" Rs "+ad.value2, style:TextStyle(background: Paint()
                    ..strokeWidth = 6.0
                    ..color = Colors.yellow
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round
                    ) 
                  ),
            //color: Colors.yellow,
            
            //margin: EdgeInsets.all(5),
          ),
            ],
          ),
          //const DecoratedBox(
          //  decoration: const BoxDecoration(color: Colors.blue,),
          //  child: const Text('Some text...'),
          //),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.redAccent,size: 18,),
              Expanded(child: Text(ad.value3))
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(" ${ad.value4}  ",style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    )
    );
  }
}
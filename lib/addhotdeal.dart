import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

String adtitle,adprice,addescription,adoldprice,adtpnum,adlocation;

class AddHotDeal extends StatefulWidget {
  @override
  _AddHotDealState createState() => _AddHotDealState();
}

class _AddHotDealState extends State<AddHotDeal> {

  List<Asset> images = List<Asset>();
  bool carosal = false;
  String _error = 'No Error Dectected';
  List<String> imageUrls = <String>[];


  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages(){
  
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          //List list123 = 
          Firestore.instance.collection('hotdeals').document(documnetID).setData({
            'urls':imageUrls,
            'value1':adtitle,
            'value2':adprice,
            'phone': "+941887412",
            'value3':adoldprice,
            'value4':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
            'location':adlocation,
            'description':addescription,
            //'value2':carPrice,
            //'value3':testLocation,
          }).then((_){
            
            //SnackBar snackbar = SnackBar(content: Text('Data Uploaded Successfully'));
            //widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
              carosal =false;
              
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }



  
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));

    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      carosal = true;
      print('<<<<<<<<<<<<<<<<<<<');
      print(images);
      
      
      //_listOfImages = imageUrls.cast<NetworkImage>();
      _error = error;
    });
  }
  
  
  Widget _imageShow(){
    if(carosal==true){
      return CarouselSlider(
        items: images
        .map((e) => AssetThumb(asset:e, width: 300, height: 300,))
        .toList(),
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 /9 ,
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

        ),  
      );
    }
    else{
      return Text('Images not yet selected');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hot Deal"),
      ),
      body: ListView(
        children: <Widget>[
          //Text("Ranish"),
          SizedBox(height: 20,),
          Card(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged:  (value) {
                         adtitle=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Ad Title',
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                   ),
                   SizedBox(height: 20,),

                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 15,
                      onChanged:  (value) {
                           addescription=value;         
                                  },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.black)
                         ),
                        hintText: 'Enter Description here',
                        labelText: 'Description ',
                        prefixIcon: Icon(Icons.add_circle)
                      ),
                    ),
                    SizedBox(height: 20,),

                   TextFormField(
                    onChanged:  (value) {
                         adprice=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Price';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Ad Price',
                      labelText: 'Price',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                   ),
                   SizedBox(height: 20,),

                   TextFormField(
                    onChanged:  (value) {
                         adoldprice=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Old Price';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Ad Old Price',
                      labelText: 'Old Price',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                   ),
                   SizedBox(height: 20,),
                   TextFormField(
                    onChanged:  (value) {
                         adtpnum=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Telephone number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Telephone number',
                      labelText: 'Telephone number',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                   ),
                   SizedBox(height: 20,),
                   TextFormField(
                    onChanged:  (value) {
                         adlocation=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Location';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Location',
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                   ), 
                   SizedBox(height: 20,),

                    RaisedButton(
                      child: Text("ad photos"),
                      onPressed: loadAssets,
                    ),
                    SizedBox(height: 20,),
                    _imageShow(),
                    SizedBox(height: 20,),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    Text("data"),
                    RaisedButton(
                       child: Text("Submit"),
                       onPressed: (){
                         if(images.length==0){
                          showDialog(context: context,builder: (_){
                            return AlertDialog(
                              backgroundColor: Theme.of(context).backgroundColor,
                             content: Text("No image selected",style: TextStyle(color: Colors.white)),
                             actions: <Widget>[
                              RaisedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                              )

                             ],
                            );
                          });
                        }
                        else{
                          uploadImages();
                          }
                       },
                    ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
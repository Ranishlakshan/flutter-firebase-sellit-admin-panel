import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CarModel {
  String value1;
  String value2;
  String value3;
  String value4;
  //String caryear;
  String carimage;
  String docID;

  CarModel(String value1, String value2,String value3, String value4, String carimage ,String docID){
    this.value1 = value1;
    this.value2 = value2;
    this.value3 = value3;
    this.value4 = value4;
    this.carimage = carimage;
    this.docID = docID;
  }

  //CarModel.fromJson(Map<String, dynamic> json) {
  //  carBrand = json['userId'];
  //  caryear = json['id'];
  //  carimage = json['title'];
  //}


  // in here value4 means DATE
  getData() async {
    return await Firestore.instance.collection('ads').orderBy('value4',descending: true).where('reviewstatus',isEqualTo: false).snapshots();
    
  }

  getAllData() async {
    return await Firestore.instance.collection('ads').orderBy('value4',descending: true).snapshots();
    
  }

  //getData(String name1) async {
  //  return await Firestore.instance.collection('ads').orderBy('value4',descending: true).where('reviewstatus',isEqualTo: true).snapshots();
  //  
  //}

//void setcarBrand(String carBrand){
//this.carBrand = carBrand;
//}
//
//void setcarYear(String carYear){
//this.carBrand = carYear;
//}
//
//void setcarImage(String carImage){
//this.carBrand = carBrand;
//}
//
//void setdocID(String docID){
//  this.docID = docID;
//}
//
//String getBrand(){
//  return carBrand;
//}
//String getYear(){
//  return caryear;
//}
String getdocID(){
  return docID;
}

getSearch(String text) async {
  //var result;
  //var dbresult =Firestore.instance.collection('ads').snapshots();
  //for(int i = 0; i < dbresult.data.documents.length; i++){}
  //for(int i = 0; i < dbresult.data.length; i++){

  

  
  //String 
    //Stream<QuerySnapshot> snapshot1 = await Firestore.instance.collection('ads').where(['searchkey','brand'], arrayContains: text ).snapshots();
    //Stream<QuerySnapshot> snapshot2 = await Firestore.instance.collection('ads').where(['searchkey','brand'], arrayContains: text ).snapshots();
    //QuerySnapshot snapshot = Observer ;
    //return await Firestore.instance.collection('ads').where('searchkey', isGreaterThanOrEqualTo: text ).snapshots();
    //return await Firestore.instance.collection('ads').where('searchkey', isGreaterThanOrEqualTo: text  ).snapshots();
    //return await Firestore.instance.collection('ads').where("searchkey" ,isGreaterThanOrEqualTo: text ).snapshots();
    return await Firestore.instance.collection('ads').snapshots();


}
}

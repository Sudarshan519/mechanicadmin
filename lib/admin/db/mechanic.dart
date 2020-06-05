import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:uuid/uuid.dart';

class MechanicService{
  String ref='mechanic';
  Firestore _firestore=Firestore.instance;
  void createShop(String name){
    String id;
    String mechanicId=id;
    _firestore.collection(ref).document(mechanicId).setData({'mechanicName':name});
  }
  Future<List<DocumentSnapshot>> getMechanic(){
    return _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  }
}
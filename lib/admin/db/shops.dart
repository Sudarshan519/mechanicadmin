import 'package:cloud_firestore/cloud_firestore.dart';

class ShopService{
  String ref='shops';
  Firestore _firestore=Firestore.instance;
  void createShop(String name){
    String id;
    String shopId=id;
    _firestore.collection('shops').document(shopId).setData({'shopName':name});
  }

   Future<List<DocumentSnapshot>> getShops(){
    return _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  }
}
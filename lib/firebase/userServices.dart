import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicadmin/models/shop.dart';

class ShopServices {
  Firestore firestore = Firestore.instance;

  addshop(Shop shop) async {
    var ref = firestore.collection("Shop").document();
    shop.id = ref.documentID;
    print('saving data');
    await ref.setData(shop.toJson());
    print('data saved');
  }

  updateBook(Shop shop) async {
    print(shop.id);
    await firestore
        .collection("Shop")
        .document(shop.id)
        .updateData(shop.toJson());
  }

  delBook(shop) async {
    var ref = firestore.collection("Shop").document(shop.id);

    await ref.delete();
  }

  Future<List<Shop>> getShops() async {
    var data = await firestore.collection('Shop').getDocuments();
    return data.documents.map<Shop>((da) => Shop.fromJson(da.data)).toList();
  }
}

final ShopServices shopServices = ShopServices();

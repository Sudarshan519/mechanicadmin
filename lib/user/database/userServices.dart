import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicadmin/user/models/mechanic.dart';
import 'package:mechanicadmin/user/models/shop.dart';

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
    var ref = firestore.collection("mechaniclist").document(shop.id);

    await ref.delete();
  }

  Future<List<Mechanic>> getShops() async {
    var data = await firestore.collection('mechaniclist').getDocuments();
    return data.documents
        .map<Mechanic>((da) => Mechanic.fromJson(da.data))
        .toList();
  }
}

final ShopServices shopServices = ShopServices();

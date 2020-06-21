import 'package:firebase_database/firebase_database.dart';

class Usertype {
  String key;
  String id;
  String usertype;

  Usertype(
    this.id,
    this.usertype,
  );

  Usertype.fromSnapshot( DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value['id'],
        usertype = snapshot.value['usertype'];
  toJson() {
    return {'id': id, 'usertype': usertype};
  }

  factory Usertype.fromJson(Map<String, dynamic> json) {
    return Usertype(
      json['id'] as String,
      json['usertype'] as String,
    );
  }
}

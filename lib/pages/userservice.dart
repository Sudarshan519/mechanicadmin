import 'package:firebase_database/firebase_database.dart';

class UserService {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = 'users';
  createUser() {
    _database.reference().child(ref).push().set({
      'name': 'sudarshan',
      'email': 'email',
      'pass': 'pass',
    }).catchError((e) => {print(e.toString())});
  }
}

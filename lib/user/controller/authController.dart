// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '../models/user.dart';

// class AuthController extends GetxController {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Rx<User> _firebaseUser = Rx<User>();
//   User get user => _firebaseUser.value;
//   @override
//   void onInit() {
//     super.onInit();
//     _firebaseUser.bindStream(_auth.authStateChanges());
//   }

//   Future<void> createUser(String name, String email, String password) async {
//     try {
//       UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on PlatformException catch (e) {
//       Get.snackbar("Error creating user", e.message);
//     }
//   }

//   Future<void> login(String email, String password) async {
//     try {
//       UserCredential _authResult = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on PlatformException catch (e) {
//       Get.snackbar(e.message, e.details);
//     }
//   }

//   verifyuser() async {
//     User user = FirebaseAuth.instance.currentUser;

//     if (!user.emailVerified) {
//       await user.sendEmailVerification();
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } on PlatformException catch (e) {
//       Get.snackbar("Signing out", e.message);
//     }
//   }
// }

// final authController = AuthController();

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mechanicadmin/signin.dart';
import 'package:mechanicadmin/user/pages/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isLoggedin;

  SharedPreferences preferences;
  isSignedIn(context) async {
    await FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainScreen(user)));
      } else
        return Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => SignInPage()));
    });
    // preferences = await SharedPreferences.getInstance();
    //  isLoggedin = await googleSignIn.isSignedIn();
    // if (isLoggedin)
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen('')));
    // else {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (_) => SignInPage()));
    // }
  }

  // //create user obj based on firebase user
  // User _userFromFirebaseUser(FirebaseUser user) {
  //   return user != null ? User() : null;
  // }

  // //auth change user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged
  //       //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //       .map(_userFromFirebaseUser);
  // }

  //sign in anon

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register in with email
  // Future registerwithEmail(String email, password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // //register with email
  // Future signInEmail(String email, password) async {
  //   try {
  //     AuthResult result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future signIn(context, email, password) async {
    AuthResult authResult;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => authResult);
    FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        //insert user to collection
        Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'profilePicture': firebaseUser.photoUrl
        });

        await preferences.setString('id', firebaseUser.uid);
        await preferences.setString('username', firebaseUser.displayName);
        await preferences.setString('photoUrl', firebaseUser.photoUrl);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => MainScreen(firebaseUser)));
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['displayName']);
        await preferences.setString('photoUrl', documents[0]['photoUrl']);
      }
    }
  }

  Future handleSignIn(context) async {
    preferences = await SharedPreferences.getInstance();

    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    AuthResult authResult = await _auth.signInWithCredential(credential);
    //print(firebaseUser.user.toString());
    FirebaseUser firebaseUser = authResult.user;
    //print(firebaseUser.user);
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        //insert user to collection
        Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'profilePicture': firebaseUser.photoUrl,
          //'usertype':firebaseUser.usertype,
        });
        await preferences.setString('id', firebaseUser.uid);
        await preferences.setString('username', firebaseUser.displayName);
        await preferences.setString('photoUrl', firebaseUser.photoUrl);
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['displayName']);
        await preferences.setString('photoUrl', documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(
          msg: "Login was successful ${firebaseUser.displayName}");
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainScreen(firebaseUser);
      }));
    }
  }

  //signout
  Future signOut() async {
    return _auth.signOut().then((value) async {
      await preferences.setString('id', null);
      await preferences.setString('username', null);
      await preferences.setString('photoUrl', null);
    });
  }
}

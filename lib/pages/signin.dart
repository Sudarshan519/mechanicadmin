import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:mechanicadmin/pages/mainscreen.dart';
import 'package:mechanicadmin/pages/signup.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = true;
  bool isLoggedin = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  final textStyle = new TextStyle(fontSize: 16, color: Colors.black);
  bool _toggleVisibility = true;
  final _formKey = GlobalKey<FormState>();

  Widget _buildEmailField() {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white.withOpacity(0.5),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
            icon: Icon(Icons.email),
            //border: OutlineInputBorder(),
          ),
          validator: (val) {
            if (val.length < 6) {
              return 'Enter a password 6+ char long';
            } else if (val.isEmpty) return 'Cannot be empty';
            else return '';

            // onChanged:
            // (val) {
            //   print(val);
            //   setState(() => {email = val});
            // };
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          validator: (val) {
            if (val.length < 6) {
              return 'Enter a password 6+ char long';
            }
            if (val.isEmpty) return 'Enter a password of valid length';
            else return '';
          },
          onChanged: (val) {
            print(val);
            setState(() => password = val);
          },
          obscureText: _toggleVisibility,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outline),
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _toggleVisibility = !_toggleVisibility;
                  });
                },
                icon: _toggleVisibility
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
        ),
      ),
    );
  }

  // void isSignedIn() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   preferences = await SharedPreferences.getInstance();
  //   isLoggedin = await googleSignIn.isSignedIn();
  //   if (isLoggedin)
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen('')));
  //   else {
  //     print('signin failed');
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();

   // isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.5),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  SizedBox(height: 20),
                  _buildPasswordField(),
                  SizedBox(height: 20),
                  Text(
                    "Forget Password?",
                    style: textStyle.copyWith(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });

                if (_formKey.currentState.validate()) {
                  signIn();
                }
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue.withOpacity(.5),
                ),
                child: Center(
                    child: Text(
                  "Sign In ",
                  style: textStyle.copyWith(color: Colors.white, fontSize: 24),
                )),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                //signIn();
                handleSignIn();
                //print('tapped');
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: loading ? Colors.green : Colors.red,
                ),
                child: Center(
                    child: Text(
                  "Sign In With Google",
                  style: textStyle.copyWith(color: Colors.white, fontSize: 24),
                )),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account ?",
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return SignUpPage();
                    }));
                  },
                  child: Text(
                    "Signup",
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    AuthResult authResult;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => authResult);
    FirebaseUser firebaseUser = authResult.user;
    setState(() {
      loading = false;
    });
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
            builder: (_) => MainScreen(firebaseUser.displayName)));
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['displayName']);
        await preferences.setString('photoUrl', documents[0]['photoUrl']);
      }
    }
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication;
    await googleUser.authentication.then((value) {
      if (value != null) googleSignInAuthentication = value;
    });
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
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
          'profilePicture': firebaseUser.photoUrl
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
        return
        MainScreen(firebaseUser.displayName);
      }));
      setState(() {
        loading = false;
      });
    }
  }
}

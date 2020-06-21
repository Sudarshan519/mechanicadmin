import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mechanicadmin/admin/adminhome.dart';
import 'package:mechanicadmin/business/businesshome.dart';
import 'package:mechanicadmin/signup.dart';
import 'package:mechanicadmin/user/models/usertype.dart';
import 'package:mechanicadmin/widgets/common.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'user/pages/mainscreen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  DatabaseReference userRef;
  List<Usertype> users = List();
  Usertype user;
  SharedPreferences preferences;
  bool loading = true;
  String _selectedItem = 'admin';

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
            } else if (val.isEmpty)
              return 'Cannot be empty';
            else
              return null;
          },
          onChanged: (v) {
            print(v);
            setState(() {
              email = v;
            });
            print(email);
            return '';
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
            if (val.isEmpty)
              return 'Enter a password of valid length';
            else
              return '';
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

  @override
  void initState() {
    super.initState();
    user = Usertype('', 'admin');
    final FirebaseDatabase database = FirebaseDatabase();
    userRef = database.reference().child('users');
    userRef.onChildAdded.listen(_onEntryAdded);
    userRef.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.5),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  SizedBox(height: 20),
                  _buildPasswordField(),
                  SizedBox(height: 20),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: DropdownButton(
                  //     value: _selectedItem,
                  //     onChanged: (v) {
                  //       setState(() {
                  //         _selectedItem = v;
                  //       });
                  //     },
                  //     items: [
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Admin',
                  //           style: heading,
                  //         ),
                  //         value: 'a',
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'User',
                  //           style: heading,
                  //         ),
                  //         value: 'u',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      value: _selectedItem,
                      onChanged: (v) {
                        setState(() {
                          _selectedItem = v;
                          user.usertype = _selectedItem;
                        });
                        print(_selectedItem);
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Admin',
                            style: heading,
                          ),
                          value: 'admin',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'User',
                            style: heading,
                          ),
                          value: 'user',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Business',
                            style: heading,
                          ),
                          value: 'business',
                        ),
                      ],
                    ),
                  ),
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
            RaisedButton(
              onPressed: () {
                print(users.length);
              },
            ),
            InkWell(
              onTap: () async {
                print(email);
                print(password);
                AuthResult authResult =
                    await firebaseAuth.signInWithEmailAndPassword(
                        email: email, password: password);
                if (authResult != null) {
                  String usertype;
                  FirebaseUser firebaseUser = authResult.user;
                  FirebaseDatabase.instance
                      .reference()
                      .child('messages')
                      .child(firebaseUser.uid)
                      .child('usertype')
                      .set({usertype = 'usestype'});
                  print(usertype);

                  Fluttertoast.showToast(
                      msg: "Login was successful ${firebaseUser.displayName}");
                  // Navigator.push(context, MaterialPageRoute(builder: (_) {
                  //   return MainScreen(firebaseUser);
                  // }));
                } else
                  Fluttertoast.showToast(msg: 'Failed login');
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
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
    AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password).catchError(print);
    if (authResult != null) {
      FirebaseUser firebaseUser = authResult.user;

      await preferences.setString('id', firebaseUser.uid);
      await preferences.setString('username', firebaseUser.displayName);
      await preferences.setString('photoUrl', firebaseUser.photoUrl);
      Fluttertoast.showToast(
          msg: "Login was successful ${firebaseUser.displayName}");
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainScreen(firebaseUser);
      }));
    }
    else{
      
      
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

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'profilePicture': firebaseUser.photoUrl,
        });
        await preferences.setString('id', firebaseUser.uid);
        await preferences.setString('username', firebaseUser.displayName);
        await preferences.setString('photoUrl', firebaseUser.photoUrl);
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['displayName']);
        await preferences.setString('photoUrl', documents[0]['photoUrl']);
      }
      setState(() {
        user.id = firebaseUser.uid;
      });
      Fluttertoast.showToast(
          msg: "Login was successful ${firebaseUser.displayName}");
      if (users == null)
        setUsertype(firebaseUser);
      else
        for (int i = 0; i < users.length; i++) {
          if (users[i].id == firebaseUser.uid) {
            await preferences.setString('usertype', user.usertype);
            setState(() {
              user.usertype = users[i].usertype;
            });
            // FirebaseDatabase.instance
            //     .reference()
            //     .child('messages')
            //     .child(firebaseUser.uid)
            //     .once();
            if (users[i].usertype == 'user')
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MainScreen(firebaseUser);
              }));
            else if (users[i].usertype == 'business')
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BusinessHomePage(firebaseUser);
              }));
            else
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AdminHomePage(firebaseUser);
              }));
          }
        }

      //getEmail(firebaseUser);

      setState(() {
        loading = false;
      });
    }
  }

  setUsertype(FirebaseUser firebaseUser) async {
    // usertype = Usertype('', '');itemRef.push().set(item.toJson());
    userRef.push().set(user.toJson());
    if (user.usertype == 'user')
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainScreen(firebaseUser);
      }));
    else if (user.usertype == 'business')
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return BusinessHomePage(firebaseUser);
      }));
    else
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return AdminHomePage(firebaseUser);
      }));
  }

  void _onEntryAdded(Event event) {
    users.add(Usertype.fromSnapshot(event.snapshot));
  }

  void _onEntryChanged(Event event) {}
}

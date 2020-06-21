
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mechanicadmin/business/businesshome.dart';
import 'package:mechanicadmin/signin.dart';
import 'package:mechanicadmin/user/pages/mainscreen.dart';
import 'package:mechanicadmin/widgets/common.dart';

import 'admin/adminhome.dart';
import 'user/models/usertype.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedItem = 'user';

  bool _anchorToBottom = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseUser firebaseUser;
  final _formKey = GlobalKey<FormState>();
  DatabaseReference databaseRef;
  Usertype usertype;
  @override
  void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase();
    usertype = Usertype('', 'admin');
    databaseRef = database.reference().child('users');
  }

  @override
  void dispose() {
    super.dispose();
    // _messagesSubscription.cancel();
    // _counterSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 25),
          Text(
            'SignUp',
            style: appStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: '  username',
                          border: InputBorder.none),
                      controller: usernameController,
                      validator: (v) {
                        if (v.isEmpty) return 'username cannot be empty';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: '           email',
                          border: InputBorder.none),
                      controller: emailController,
                      validator: (v) {
                        if (v.isEmpty) return '   email cannot be empty';
                        if (v.length < 5) return 'enter valid email';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Material(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: '          password',
                          border: InputBorder.none),
                      validator: (v) {
                        if (v.isEmpty) return 'password cannot be empty';
                        if (v.length < 8)
                          return 'password shoult be greater than 8 char empty';
                        return null;
                      },
                      controller: passwordController,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: DropdownButton(
                      value: _selectedItem,
                      onChanged: (v) {
                        setState(() {
                          _selectedItem = v;
                        });
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
                            'user',
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
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.transparent,
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text('submit'))),
                    onPressed: () {
                      // print(_selectedItem);
                      //if (_formKey.currentState.validate()) {
                      //print('$_selectedItem');
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        setState(() {
                          firebaseUser = value.user;
                        });
                      });
                      usertype.usertype = _selectedItem;
                      usertype.id = firebaseUser.uid;
                      setUsertype(firebaseUser);

                      // }
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignInPage();
                      }));
                    },
                    child: Text('Already have account\tSignIn'),
                  )
                ],
              ),
            ),
          ),
          // ListView(children: <Widget>[
          //  for(int i=0;i<100;i++)

          ListTile(
            leading: Checkbox(
              onChanged: (bool value) {
                setState(() {
                  _anchorToBottom = value;
                });
              },
              value: _anchorToBottom,
            ),
            title: const Text('Anchor to bottom'),
          ),
          // Flexible(
          //   child: FirebaseAnimatedList(
          //     key: ValueKey<bool>(_anchorToBottom),
          //     query: _messagesRef,
          //     reverse: _anchorToBottom,
          //     sort: _anchorToBottom
          //         ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
          //         : null,
          //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
          //         Animation<double> animation, int index) {
          //       return SizeTransition(
          //         sizeFactor: animation,
          //         child: ListTile(
          //           trailing: IconButton(
          //             onPressed: () =>
          //                 _messagesRef.child(snapshot.key).remove(),
          //             icon: Icon(Icons.delete),
          //           ),
          //           title: Text(
          //             "$index: ${snapshot.value.toString()} ",
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  setUsertype(FirebaseUser firebaseUser) async {
    databaseRef.push().set(usertype.toJson());
    if (usertype.usertype == 'firebaseUser')
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainScreen(firebaseUser);
      }));
    else if (usertype.usertype == 'business')
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return BusinessHomePage(firebaseUser);
      }));
    else
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return AdminHomePage(firebaseUser);
      }));
  }
}

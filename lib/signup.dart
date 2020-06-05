import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mechanicadmin/business/businesshome.dart';

import 'package:mechanicadmin/signin.dart';
import 'package:mechanicadmin/user/pages/mainscreen.dart';
import 'package:mechanicadmin/widgets/common.dart';

import 'admin/adminhome.dart';
import 'user/models/usertype.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.app});
  final FirebaseApp app;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedItem = 'firebaseUser';
  int _counter;
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
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

    _counterRef = FirebaseDatabase.instance.reference().child('counter');

    // final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _messagesRef = database.reference().child('messages');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      Fluttertoast.showToast(
          msg: 'Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      setState(() {});
    });
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _increment(Map value) async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      _messagesRef.push().set(value);
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
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
                        return '';
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
                            'firebaseUser',
                            style: heading,
                          ),
                          value: 'firebaseUser',
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
                    //color: Colors.transparent,
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text('submit'))),
                    onPressed: () {
                      // print(_selectedItem);
                      if (_formKey.currentState.validate()) {
                        print('$_selectedItem');
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          setState(() {
                            firebaseUser = value.user;
                          });
                        });
                        usertype.usertype=_selectedItem;
                        usertype.id=firebaseUser.uid;
                        // _increment(<String, String>{
                        //   'username': '${usernameController.text}',
                        //   'email': '${emailController.text}',
                        //   'id': '$_counter',
                        //   'usertype': '$_selectedItem'
                        // });
                        setUsertype(firebaseUser);

                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MainScreen(firebaseUser);
                        }));
                      }
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
          Flexible(
            child: FirebaseAnimatedList(
              key: ValueKey<bool>(_anchorToBottom),
              query: _messagesRef,
              reverse: _anchorToBottom,
              sort: _anchorToBottom
                  ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                  : null,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () =>
                          _messagesRef.child(snapshot.key).remove(),
                      icon: Icon(Icons.delete),
                    ),
                    title: Text(
                      "$index: ${snapshot.value.toString()} ",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  setUsertype(FirebaseUser firebaseUser) async {
    // usertype = Usertype('', '');itemRef.push().set(item.toJson());
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

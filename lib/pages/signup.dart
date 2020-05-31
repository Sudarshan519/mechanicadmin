import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:mechanicadmin/pages/mainscreen.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.app});
  final FirebaseApp app;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _counter;
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  bool _anchorToBottom = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DatabaseError _error;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _messagesRef = database.reference().child('messages');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
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
      
        body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Sign Up'),
          TextFormField(
            decoration: InputDecoration(hintText: 'username'),
            controller: usernameController,
            validator: (v) {
              if (v.isEmpty)
                return 'username cannot be empty';
              else
                return '';
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'email'),
            controller: emailController,
            validator: (v) {
              if (v.isEmpty) return 'email cannot be empty';
              if (v.length < 5) return 'enter valid email';
              return '';
            },
            // onChanged: (value) {
            //   email = value;
            // },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'password'),
            validator: (v) {
              if (v.isEmpty) return 'password cannot be empty';
              if (v.length < 8)
                return 'password shoult be greater than 8 char empty';
              return '';
            },
            controller: passwordController,
          ),
          RaisedButton(
            child: Text('submit'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print(
                    '${emailController.text} ${passwordController.text} ${usernameController.text}');
                FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text);
                _increment(<String, String>{
                  'username': '${usernameController.text}',
                  'email': '${emailController.text}',
                  'id': '$_counter'
                });
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MainScreen('');
                }));
              }
            },
          ),
          Center(
            child: _error == null
                ? Text(
                    'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
                    'This includes all devices, ever.',
                  )
                : Text(
                    'Error retrieving button tap count:\n${_error.message}',
                  ),
          ),
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
          FirebaseAnimatedList(
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
                    onPressed: () => _messagesRef.child(snapshot.key).remove(),
                    icon: Icon(Icons.delete),
                  ),
                  title: Text(
                    "$index: ${snapshot.value.toString()} ",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}

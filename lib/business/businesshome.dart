import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BusinessHomePage extends StatefulWidget {
  final FirebaseUser user;
  BusinessHomePage(this.user);
  
  @override
  _BusinessHomePageState createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
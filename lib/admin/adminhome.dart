import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/admin.dart';



class AdminHomePage extends StatelessWidget {
  final FirebaseUser user;
  AdminHomePage(this.user);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminSite(),
    );
  }
}


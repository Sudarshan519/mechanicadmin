import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mechanicadmin/services/authServices.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () => AuthService().isSignedIn(context));
  }

  @override
  Widget build(context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //color: Colors.grey,
          image: DecorationImage(
              image: AssetImage(
                'images/c.jpg',
              ),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'No worries for car breakdown',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Locate nearby mechanic\n\t\t request for Repair in no time...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'We Find Mechanic in\n\t\t Just a click',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Image(image: AssetImage('images/mechanic1.png')),
            CircularProgressIndicator()
          ],
        ),
        //color:Colors.grey
      ),
    );
  }
}

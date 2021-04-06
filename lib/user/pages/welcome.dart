import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicadmin/widgets/button.dart';

import 'login.dart';
import 'signup.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Container(
                      child: Stack(children: [
                    Image.asset('assets/serviceman.png'),
                    Container(
                      color: Colors.green.withOpacity(.2),
                    )
                  ])),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Welcome to Mechanic Finder',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Column(
                    children: [
                      Text('Make reservation  in real time'),
                    ],
                  ),
                  CustomButton(
                      width: double.infinity,
                      name: 'Login',
                      color: Colors.green,
                      textColor: Colors.white,
                      onpress: () {
                        Get.to(Login());
                      }),
                  CustomButton(
                      width: double.infinity,
                      name: 'SignUp',
                      color: Colors.blueGrey,
                      textColor: Colors.green,
                      onpress: () {
                        Get.to(SignUp());
                      }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

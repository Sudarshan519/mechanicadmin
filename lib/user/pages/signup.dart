import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'widgets/button.dart';
import 'widgets/text_field.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    obscureText: false,
                    controller: email,
                    label: 'email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    obscureText: false,
                    controller: password,
                    label: 'password',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                        name: 'Login',
                        color: Colors.green,
                        textColor: Colors.white,
                        onpress: () {
                          if (_formKey.currentState.validate()) Get.to(Home());
                          {
                            Get.to(Home());
                            Get.snackbar('Signing in', "Authenting user",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    
                      name: 'Dont have account \tSignUp',
                      color: Colors.white,
                      textColor: Colors.green,
                      onpress: () {
                        Navigator.pushNamed(context, 'signup');
                      }),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicadmin/services/authServices.dart';
import 'package:mechanicadmin/user/pages/widgets/button.dart';

import 'home.dart';
import 'signup.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

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
                        'Log In',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: false,
                    controller: email,
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Cannot be empty';
                      } else if (!v.isEmail) {
                        return 'Enter a valid email';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Cannot be empty';
                      } else if (v.length < 8) {
                        return 'Enter a provide password greater than 7 with letters containing !#@';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
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
                          if (_formKey.currentState.validate()) {
                            authService.signIn(email.text, password.text);
                            Get.snackbar('Signing in', "Authenting user",
                                snackPosition: SnackPosition.BOTTOM);
                            if (authService.auth.currentUser() != null)
                              Get.to(Home());
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
                        Get.to(SignUp());
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

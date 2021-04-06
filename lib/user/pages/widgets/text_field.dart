import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField(
      {Key key, this.hintText, this.obscureText, this.controller, this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v.isEmpty)
          return '$label is empty';
        else if (label == 'email' && !GetUtils.isEmail(v))
          return 'Please provide a valid $label';
        else if (label == 'password' && v.length < 8)
          return 'Provide strong $label length greater than 8';
        else
          return null;
      },
      decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      obscureText: obscureText,
    );
  }
}

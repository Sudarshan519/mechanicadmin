import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function onpress;
  final String name;
  final Color textColor;
  final double width;

  const CustomButton(
      {Key key,
      this.color,
      this.onpress,
      this.name,
      this.textColor,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: width,
        child: RaisedButton(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.white38, width: 1)),
          onPressed: onpress,
          child: Text(
            name,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ));
  }
}

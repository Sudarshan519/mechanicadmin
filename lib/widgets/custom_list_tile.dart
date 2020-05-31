import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  CustomListTile(this.icon, this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}

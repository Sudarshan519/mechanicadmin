import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mechanicadmin/admin/db/mechanic.dart';

class AddMechanic extends StatefulWidget {
  @override
  _AddMechanicState createState() => _AddMechanicState();
}

class _AddMechanicState extends State<AddMechanic> {
  MechanicService _mechanicService = MechanicService();
  List<DocumentSnapshot> mechanic = <DocumentSnapshot>[];
  List<DocumentSnapshot> shops = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> mechanicDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> shopsDropDown = <DropdownMenuItem<String>>[];
  String _currentMechanic;

  @override
  void initState() {
    super.initState();
    _getmechanic();
    mechanicDropDown = getMechanicDropDown();
  }

  List<DropdownMenuItem<String>> getMechanicDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for (DocumentSnapshot mechanic in mechanic) {
      items.add(DropdownMenuItem(
        child: Text(mechanic['mechanic']),
        value: mechanic['mechanic'],
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          DropdownButton(
            onChanged: (v) {},
            items: mechanicDropDown,
            value: _currentMechanic,
          )
        ],
      ),
    ));
  }

  _getmechanic() async {
    List<DocumentSnapshot> data = await _mechanicService.getMechanic();
    setState(() {
      mechanic = data;
    });
  }
}

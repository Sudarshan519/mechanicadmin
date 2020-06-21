import 'package:flutter/material.dart';

class CreateBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(children: <Widget>[
        Center(child: Text('Invoice'),),
        Text('OrderId'),
        Text('CustumerID'),
        Row(children: <Widget>[
          Column(children: <Widget>[
            Text('Ref')
          ],),
           Column(children: <Widget>[
             Text('Description')
           ],),
            Column(children: <Widget>[
              Text('Price')
            ],),
             Column(children: <Widget>[
               Text('Total')
             ],)
        ],),
        Column(children: <Widget>[
               Text('Net'),
               
             ],)
      ],)
    );
  }
}
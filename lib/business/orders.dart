import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              for (int i = 0; i < 100;i++)
                Card(
                                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Order id:12111'),
                      Text('Customer id:deq1cve'),
                      Text('Customer name'),
                      Text('Customer location'),
                      Text('Customer vechile'),
                      Text('Generate bill:'),
                      Row(
                        children: <Widget>[
                          OutlineButton(
                            onPressed: () {},
                            child: Text('Accept'),
                          ),
                          OutlineButton(
                            onPressed: () {},
                            child: Text('Reject'),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

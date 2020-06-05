import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanicadmin/widgets/common.dart';
import 'package:url_launcher/url_launcher.dart';

class PayMent extends StatefulWidget {
  @override
  _PayMentState createState() => _PayMentState();
}

class _PayMentState extends State<PayMent> {
  void _creditcard() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Scaffold(
          appBar: AppBar(title: Text('Add debit or credit card')),
          body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.credit_card,
                          size: 30,
                        ),
                        hintText: 'add your credit card',
                        border: OutlineInputBorder()),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('Save'),
                    ),
                  ),
                ],
              )),
          // content: TextField(
          //   onChanged: (v) => {},
          // ),

          // actions: <Widget>[
          //   FlatButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('cancel'),
          //   ),
          //   new FlatButton(
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //         //waiting = false;
          //       },
          //       child: Text('Ok')),
          // usually buttons at the bottom of the dialog
          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment methods',
          style: subtitle,
        ),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: Column(
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.payment,
                        size: 40,
                      ),
                      Icon(Icons.radio_button_unchecked),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blueGrey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Maker your purchase fast and easy\n by adding a payment method now',
              style: subtitle.copyWith(fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Divider(),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add payment method',
                style: title,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _creditcard,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.payment,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Add credit or debit cart',
                    style: subtitle,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                const url = 'https://payments.google.com/manage#paymentMethods';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'More payment options',
                    style: subtitle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mechanicadmin/widgets/common.dart';

class Repairs extends StatefulWidget {
  @override
  _RepairsState createState() => _RepairsState();
}

class _RepairsState extends State<Repairs> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          // Image.asset('images/repair.jpg',fit: BoxFit.cover,),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(.5),
            child: Image.asset(
              'images/repair.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[],
                // ),
                Center(
                  child: Text(
                    'Recent repair history',
                    style: heading.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  height: 100,
                  color: Colors.white30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.payment,
                              size: 70,
                            ),
                            Text(
                              'paypal',
                              style: title,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.playlist_play,
                            size: 70,
                          ),
                          Text(
                            'imepay',
                            style: title,
                          )
                        ],
                      ),
                      for (int i = 0; i < 55; i++)
                        Row(
                          children: <Widget>[
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.scanner,
                                    size: 70,
                                  ),
                                  Text(
                                    'phonepay',
                                    style: subtitle,
                                  ),
                                ]),
                            SizedBox(width: 20)
                          ],
                        )
                    ],
                  ),
                ),

                Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Repair Progress',
                              style: title,
                            ),
                            Icon(Icons.access_time),
                          ],
                        ),
                        Text(
                          'Service Date ${DateTime.now()}',
                          style: title.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                            'Recovery Date\t 2-3 days \n We \'ll contact you turn on notification'),
                      ],
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.lightGreen,
                    child: Text('Request Delivery'),
                  ),
                ),
                Card(
                  color: Colors.black87,
                  child: ListTile(
                    leading: Text(
                      'Service Charge',
                      style: heading,
                    ),
                    trailing: Text(
                      '\$400',
                      style: subtitle,
                    ),
                  ),
                ),
                ListTile(
                    title: Text(
                  'Repair Charge',
                  style: heading,
                )),
                ListTile(
                    title: Text(
                  'Grand Total',
                  style: heading,
                )),
                // Container(
                //   height: MediaQuery.of(context).size.height * .3,
                //   child: ListView(
                //     physics: BouncingScrollPhysics(),
                //     children: <Widget>[
                //       for (int i = 0; i < 15; i++)
                //         ListTile(
                //           leading: Icon(Icons.storage),
                //           subtitle: Row(
                //             children: <Widget>[
                //               Text(
                //                 'service charge:',
                //                 style: subtitle,
                //               ),
                //               Text('\$200')
                //             ],
                //           ),
                //           title: Column(
                //             children: <Widget>[
                //               Text(
                //                 'Total cost:\$480',
                //                 style: heading.copyWith(fontSize: 25),
                //               ),
                //             ],
                //           ),
                //           trailing: RichText(
                //             text: TextSpan(children: [
                //               TextSpan(
                //                 text: 'discount:',
                //               ),
                //               TextSpan(
                //                   text: '\$40',
                //                   style: subtitle.copyWith(
                //                       color: Colors.black45, fontSize: 14)),
                //             ], style: subtitle.copyWith(fontSize: 14)),
                //           ),
                //         ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * .02),
                // Material(
                //   color: Colors.white,
                //   child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Set up Payment Method',
                //           style: subtitle.copyWith(
                //               color: Colors.black, fontWeight: FontWeight.bold),
                //         ),

                //       ]),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

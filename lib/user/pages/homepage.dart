import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haversine/haversine.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanicadmin/services/authServices.dart';
import 'package:mechanicadmin/user/database/userServices.dart';
import 'package:mechanicadmin/user/models/mechanic.dart';
import 'package:mechanicadmin/user/models/shop.dart';
import 'package:mechanicadmin/user/pages/payment.dart';
import 'package:mechanicadmin/user/pages/repairs.dart';
import 'package:mechanicadmin/widgets/common.dart';

import '../../signin.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position myPosition;
  bool isLoading = true;
  String image = 'images/a.jpg';
  List<Mechanic> shops;
  double distanceInMeters = 99999999;
  bool carwashselected = false;
  bool request = false;
  int selectedDistance;
  var arr = [];
  var raa = [];

  @override
  void initState() {
    super.initState();
    getshops();
    // getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        drawer: _buildDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .30,
                    // child: selectedDistance != null
                    //     ? MapPage(
                    //         myPosition, selectedDistance, request, shops)
                    //     : Center(child: CircularProgressIndicator())
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 50, right: 80),
                    child: Container(
                      height: MediaQuery.of(context).size.width * .08,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Builder(
                              builder: (BuildContext context) => InkWell(
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                    ),
                                    onTap: () =>
                                        Scaffold.of(context).openDrawer(),
                                  )),
                          Expanded(
                              //flex: 2,
                              child: TextField(
                            onTap: () {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    '\t\t\tSearch Fuel Stations,Repairs nearby',
                                hintStyle: TextStyle(fontSize: 14)),
                          )),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _showDialog();
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            'Order Repair',
                            style: heading,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                carwashselected = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: carwashselected
                                  //     ? Colors.blue
                                  //     : Colors.white,
                                  border: carwashselected
                                      ? Border.all(color: Colors.blue, width: 2)
                                      : null,
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.of(context).size.width * .5,
                              child: Center(
                                  child: Text('CarWash',
                                      style: heading.copyWith(
                                          color: Colors.blueGrey))),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                carwashselected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: carwashselected
                                      ? null
                                      : Border.all(
                                          color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              width: MediaQuery.of(context).size.width * .5,
                              child: Center(
                                  child: Text('GasStation',
                                      style: heading.copyWith(
                                        color: Colors.blueGrey,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          carwashselected ? carwash() : fuelStation()
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Repairs Shops Nearby',
                        style: appStyle.copyWith(color: Colors.blueGrey),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * .27,
                          color: Colors.white,
                          child: shops != null
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: shops.length,
                                  itemBuilder: (_, int i) {
                                    return Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.drive_eta,
                                          size: 40,
                                        ),
                                        Text(
                                          '${shops[i].address}',
                                          style: heading,
                                        ),
                                        arr[i] != null
                                            ? Text(
                                                '${arr[i].toStringAsFixed(2)} m ahead',
                                                style: subtitle,
                                              )
                                            : Text(''),
                                      ],
                                    );
                                  },
                                )
                              : Align(
                                  alignment: Alignment.topLeft,
                                  child: CircularProgressIndicator())),
                    ]),
              ),
            ],
          ),
        ));
  }

  Widget carwash() {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < 40; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.local_car_wash,
                  size: 50,
                  color: Colors.blueGrey,
                ),
                Text(
                  '$i\m \nahead  ',
                  textAlign: TextAlign.center,
                  style: subtitle.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget fuelStation() {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (int i = 0; i < 40; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.local_gas_station,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      'Fuels station',
                      style: subtitle,
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.user.displayName != null ? widget.user.displayName : '',
              style: title.copyWith(color: Colors.white),
            ),
            accountEmail: Text(widget.user.email,
                style: subtitle.copyWith(color: Colors.white)),
            currentAccountPicture: InkWell(
              onTap: () => updateImage(),
              child: CircleAvatar(
                backgroundImage: image != null
                    ? NetworkImage(widget.user.photoUrl ?? '')
                    : AssetImage(
                        image,
                      ),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.person_add)),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Repairs(),
                  ));
            },
            leading: Icon(Icons.build),
            title: Text('Repairs'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          ListTile(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) {
              return PayMent();
            })),
            leading: Icon(Icons.payment),
            title: Text('PaymentMethods'),
          ),
          ListTile(
            onTap: _feedBack,
            leading: Icon(Icons.notifications),
            title: Text('Help and FeedBack'),
          ),
          ListTile(
            onTap: _privacy,
            leading: Icon(Icons.notifications_active),
            title: Text('Privacy'),
          ),
          ListTile(
            onTap: _termsandcondition,
            leading: Icon(Icons.question_answer),
            title: Text('Terms and conditions'),
          ),
          ListTile(
            onTap: _aboutMechanicFinder,
            leading: Icon(Icons.notifications),
            title: Text('About Mechanic Finder'),
          ),
          ListTile(
            onTap: () {
              AuthService().signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ));
            },
            leading: Icon(Icons.lock_open),
            title: Text('Log out'),
          )
        ],
      ),
    );
  }

  getDistance() async {
    //final harvesine =
    for (int i = 0; i != shops.length; i++) {
      double distance = new Haversine.fromDegrees(
        latitude1: myPosition.latitude,
        longitude1: myPosition.longitude,
        // latitude2: shops[i].latitude,
        // longitude2: shops[i].longitude
      ).distance();
      setState(() {
        arr.length = shops.length;
        arr[i] = distance;
        if (distance < distanceInMeters) {
          distanceInMeters = distance;
          selectedDistance = i;
        }
      });
    }
  }

  // getDistance() async {
  //   for (int i = 0; i != shops.length; i++) {
  //     await Geolocator()
  //         .distanceBetween(myPosition.latitude, myPosition.longitude,
  //             shop[i].latitude, shop[i].longitude)
  //         .then((value) {
  //       if (value >= distanceInMeters)
  //         arr[i] = value;
  //       else {
  //         setState(() {
  //           distanceInMeters = value;
  //           selectedDistance = i;
  //           arr[i] = value;
  //           raa[i] = value;
  //           isLoading = false;
  //         });
  //       }
  //       raa.sort();

  //       print(raa);
  //     });
  //   }
  // }

  getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      setState(() {
        myPosition = value;
      });
      getDistance();
    });
  }

  getshops() async {
    await shopServices.getShops().then((value) => {
          setState(() {
            shops = value;
            arr.length = shops.length;
            raa.length = shops.length;
          })
        });
    getLocation();
  }

  updateImage() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((value) {
      try {
        if (value != null) {
          //print(value.path);

          setState(() {
            image = value.path;
          });
        }
      } catch (e) {}
    });
  }

  void _aboutMechanicFinder() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("About MechanicFinder"),
          content: new Text(
              "The mechanic finder app is an mobile app product which aims to fast and relaible recovery of vechile brokedown over road and provides a reliable service in managing them."),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok')),
          ],
        );
      },
    );
  }

  void _feedBack() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Provide us feedback for improvements "),
          content: TextField(
            onChanged: (v) => {},
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //waiting = false;
                },
                child: Text('Ok')),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  void _termsandcondition() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("About MechanicFinder"),
          content: new Text(
              "The mechanic finder app is an mobile app product which aims to fast and relaible recovery of vechile brokedown over road and provides a reliable service in managing them.\n1.General\n2.Services\nService fees / Payments/Invoices\n3.No transaction fee for app\n4.Termination/Plan change /Refund\nProhibited conduct\nNotice\nPrivacy\n15.Reservation of rights\n4.Limitation of liabiality\nGovernment law \n Age of majority\nEntire agreement"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //waiting = false;
                },
                child: Text('Ok')),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  void _privacy() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Privacy Page"),
          content: new Text(
              "The mechanic finder app is an mobile app product which aims to fast and relaible recovery of vechile brokedown over road and provides a reliable service in managing them."),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //waiting = false;
                },
                child: Text('Ok')),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm request??"),
          content:
              new Text("Requesting service.You will be charged per service"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel')),
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                setState(() {
                  request = true;
                });
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Please set up payment method first.'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('ok'),
                          )
                        ],
                      );
                    });

                setState(() {
                  request = true;
                });
                Fluttertoast.showToast(
                    msg: 'service currently unavailable for your region');

                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

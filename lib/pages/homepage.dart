import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanicadmin/models/marker.dart';
import 'package:mechanicadmin/models/shop.dart';

import 'package:mechanicadmin/pages/map.dart';
import 'package:mechanicadmin/pages/repairShops.dart';

import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage(this.username);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static double myLatitude;
  //static double myLongitude;
  //List positon = [myLatitude, myLongitude];
  SharedPreferences preferences;
  Position myPosition;
  bool isLoading = true;
  String image = "images/a.jpg";
  bool istouched = false;
  List<Shop> shops;
  double distanceInMeters = 99999999;
  BitmapDescriptor myicon;
  BitmapDescriptor shopicon;
  //List<Placemark> placemark;
  bool request = false;
  int selectedDistance;
  var arr = [1.1, 2.1, 3.1, 4];

  List<ShopLocation> _marker = locations;
  //List<Shop> _marker;
  Placemark address;
  //double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  @override
  void initState() {
    super.initState();
    // shopServices.getShops().then((value) => ((V){
    //   setState(() {
    //     print(value.toString());
    //   //  _marker=value;
    //    });

    // }));
    getLocation();
    
    //
  }

  void getDistance(context, i) async {
    try {
      await Geolocator()
          .distanceBetween(myPosition.latitude, myPosition.longitude,
              context.latitude, context.longitude)
          .then((value) {
        if (value >= distanceInMeters)
          arr[i] = value;
        else {
          setState(() {
            distanceInMeters = value;
            selectedDistance = i;
            arr[i] = value;
            print(value);
            //Fluttertoast.showToast(msg: value.toString());
            isLoading = false;
          });
          print(value);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getaddress() async {
    // List<Placemark> placemark =
    //     await Geolocator().placemarkFromAddress("Gronausestraat 710, Enschede");
    // print(placemark.toString());
    if (myPosition != null) {
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        myPosition.latitude,
        myPosition.longitude,
      );
      print(placemark[0].locality);
      print(placemark[0].subLocality);
      print(placemark[0].administrativeArea);
    }

    // await Geolocator()
    //     .placemarkFromCoordinates(myPosition.latitude, myPosition.longitude)
    //     .then((value) {
    //   try {
    //     print(value);
    //     setState(() {
    //       print(value);
    //       placemark = value;
    //     });
    //   } catch (e) {
    //     print(e.toString());
    //     placemark = e;
    //   }
    // });
  }

  getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      try {
        {
          print(value.toJson());
          setState(() {
            myPosition = value;

            for (int i = 0; i != _marker.length; i++) {
              getDistance(_marker[i], i);
            }
          });
        }
      } catch (e) {}
    });
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm request??"),
          content: new Text("Requesting service"),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //waiting = false;
                },
                child: Text('cancel')),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                setState(() {
                  request = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: InkWell
      // (onTap: getaddress,
      // child: Text('getlocation'),
      
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text(''),
              currentAccountPicture: InkWell(
                onTap: () => updateImage(),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
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
                      builder: (context) => Repairshops(),
                    ));
              },
              leading: Icon(Icons.shop),
              title: Text('Shops'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Help and FeedBack'),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text('Privacy'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('About Mechanic Finder'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * .35,
                    child: isLoading == false
                        ? MapPage(myPosition, selectedDistance)
                        : Center(child: CircularProgressIndicator())),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 80),
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
                                  '\t\t\t\tSearch Fuel Stations,Repairs nearby',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 200),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            _showDialog();

                            setState(() {
                              request = !request;
                            });
                          },
                          color: request ? Colors.blueGrey : Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Order Repair',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              request
                                  ? Icon(
                                      Icons.radio_button_unchecked,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.radio_button_checked,
                                      color: Colors.redAccent,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text('Fuel Station',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    Container(
                      height: MediaQuery.of(context).size.height * .15,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          for (int i = 0; i < 100; i++)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.local_gas_station,
                                  size: 80,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  'item $i',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    Text(
                      'Repairs Shops Nearby',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                        //color: Colors.grey,
                        height: MediaQuery.of(context).size.height * .27,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: _marker.length,
                          itemBuilder: (_, int i) {
                            return ListTile(
                              //color: Colors.grey[400],
                              leading: Icon(
                                Icons.track_changes,
                                size: 20,
                              ),
                              title: Text(
                                '${_marker[i].title}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),

                              subtitle: Text(
                                '${arr[i]} m ahead',
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        )),
                  ]),
            ),
            //Text(placemark.toString()),
          ],
        ),
      )
    );
  }
}

class BookRating extends StatelessWidget {
  final double score;
  const BookRating({
    Key key,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 7),
              blurRadius: 20,
            )
          ]),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.orangeAccent,
            size: 15,
          ),
          Text(
            '$score',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
        );
  }
}

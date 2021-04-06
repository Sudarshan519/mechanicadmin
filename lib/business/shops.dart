import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mechanicadmin/user/database/userServices.dart';
import 'package:mechanicadmin/user/models/mechanic.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:mechanicadmin/user/models/shop.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';


class AddShop extends StatefulWidget {
  // final Shop shop;

  // const Upload({Key key, this.shop}) : super(key: key);

  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  // File uploadImage;
  String path = 'images/a.jpg';
  bool delrequest = false;

  bool search = false;
  bool showallshops = false;
  // Future getImage() async {
  //   var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     uploadImage = tempImage;
  //   });
  // }

  final TextStyle appStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(.5));

  bool isLoading = false;
  var name = TextEditingController();
  var address = TextEditingController();
  var c = TextEditingController();
  bool istapped = false;
  var d = TextEditingController();
  List<Mechanic> shops = [];
  LatLng tappedlocation;
  static Position position;
  PlatformMapController _mapController;

  bool isUpdate = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor myicon, shopicon;
  String id;
  String city;
  TextEditingController citySearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: '$tappedlocation');
    getshops();

    // if (widget.shop != null) {
    //   setState(() {
    //     id = widget.shop.id;

    //     isUpdate = true;
    //   });
    //   name.text = widget.shop.shopName;
    //   address.text = widget.shop.latitude;
    //   d.text = widget.shop.longitude;
    //   c.text = widget.shop.address;
    // }
  }

  void getaddress(v) async {
    print(v);
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress('$v,Kathmandu');
    print(placemark[0].locality);
    setState(() {
      position = placemark[0].position;
    });

    // if (place.isNotEmpty) {
    //   List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
    //     myPosition.latitude,
    //     myPosition.longitude,
    //   );
    //   print(placemark[0].locality);
    //   print(placemark[0].subLocality);
    //   print(placemark[0].administrativeArea);
  }

  getshops() {
    shopServices.getShops().then((value) => {
          setState(() {
            shops = value;
          })
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
          content: new Text("Are you sure you want delete shop "),
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
                  delrequest = true;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Marker _buildShopMarker(context, icon) {
    return Marker(
      markerId: MarkerId(context.id),
      icon: icon,
      position: LatLng(context.latitude, context.longitude),
      consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: '${context.shopName}',
        snippet: "${context.address}",
      ),
      onTap: () async {
        //print("Marker tapped");
      },
    );
  }

  void getIcon() async {
    myicon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'images/mechanic2.jpeg',
    );
    shopicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/mechanic1.png');
    setState(() {
      //_marker.clear();
      shops = shops;
    });
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(position.latitude, position.longitude),
      //tilt: 59.440717697143555,
      zoom: 15);
  Future<void> _goToTheLake() async {
    final PlatformMapController controller = _mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(.5),
                        ),
                        child: TextFormField(
                          validator: (v) {
                            if (v.isEmpty) return 'canot be empty';
                            return '';
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'shop name',
                            border: InputBorder.none,
                            icon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.shop)),
                            prefixText: '+1',
                          ),
                          controller: name,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(.5),
                        ),
                        child: TextFormField(
                          validator: (v) {
                            if (v.isEmpty) return 'canot be empty';
                            return '';
                          },
                          decoration: InputDecoration(
                            labelText: 'shop address',
                            border: InputBorder.none,
                            icon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.shop)),
                            prefixText: '+1',
                          ),
                          controller: address,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          onChanged: (v) {
                            setState(() {
                              city = v;
                              // print(v);
                            });
                            getaddress(v);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shop),
                              labelText: 'Search location inside valley',
                              hintText:
                                  'Search for shop location eg :Gongabu,Kathmandu',
                              border: InputBorder.none,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      search = true;
                                    });
                                  },
                                  child: InkWell(
                                      onTap: () {
                                        getaddress(city);
                                        if (position != null) _goToTheLake();
                                      },
                                      child: Icon(Icons.search)))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //color: Colors.red[50],
                          decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .25,
                              child: PlatformMap(
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                onTap: (location) {
                                  print(location);
                                  setState(() {
                                    istapped = true;
                                    tappedlocation = location;
                                  });
                                },
                                markers: Set<Marker>.of([
                                  for (int i = 0; i != shops.length; i++)
                                    _buildShopMarker(shops[i], myicon),
                                  if (istapped)
                                    Marker(
                                      icon: myicon,
                                      markerId: MarkerId('context.id'),
                                      position: tappedlocation,
                                      consumeTapEvents: true,
                                      infoWindow: InfoWindow(
                                        title: name.text,
                                        snippet: address.text,
                                      ),
                                      onTap: () async {},
                                    ),
                                ]),
                                initialCameraPosition: CameraPosition(
                                    zoom: 18, target: LatLng(27.7154, 85.3123)),
                                onMapCreated: (controller) {
                                  _mapController = controller;
                                },

                                // onMapCreated: (controller) {
                                //   Future.delayed(Duration(seconds: 0)).then(
                                //     (_) {
                                //       controller.animateCamera(
                                //         CameraUpdate.newCameraPosition(
                                //           CameraPosition(
                                //             bearing: 270.0,
                                //             target: LatLng(
                                //                 position.latitude, position.longitude),
                                //             tilt: 30.0,
                                //             zoom: 18,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //   );
                                // },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // RaisedButton(
                      //   onPressed: getImage,
                      //   child: Text('Choose your file'),
                      // ),
                      // uploadImage == null
                      //     ? Text('Select an Image')
                      //     : enableUpload(),
                      InkWell(
                        child: Text('Save'),
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          print(name.text);
                          print(address.text);
                          print(tappedlocation.latitude.toString());
                          print(tappedlocation.longitude.toString());
                          Shop shop = Shop(
                            id,
                            name.text,
                            tappedlocation.latitude,
                            tappedlocation.longitude,
                            address.text,
                            path,
                          );

                          await shopServices.addshop(shop).then((v) {
                            setState(() {
                              isLoading = false;
                            });
                            getshops();
                          });
                        },
                      ),
                      // OutlineButton(
                      //   onPressed: () async {
                      //     setState(() {
                      //       isLoading = true;
                      //     });
                      //     print(name.text);
                      //     print(address.text);
                      //     print(tappedlocation.latitude.toString());
                      //     print(tappedlocation.longitude.toString());
                      //     Shop shop = Shop(
                      //       id,
                      //       name.text,
                      //       tappedlocation.latitude,
                      //       tappedlocation.longitude,
                      //       address.text,
                      //       path,
                      //     );

                      //     await shopServices.addshop(shop).then((v) {
                      //       setState(() {
                      //         isLoading = false;
                      //       });
                      //       getshops();
                      //     });
                      //   },
                      //   child: isLoading
                      //       ? CircularProgressIndicator(
                      //           strokeWidth: 2,
                      //         )
                      //       : Text('save'),
                      // ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Scaffold(body: Container(
                        color: Colors.green,
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(children: <Widget>[
                      Container(
                        child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          for (int i = 0; i < shops.length; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width*.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        shops[i].mechnicname.toUpperCase(),
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        shops[i].address,
                                        style: appStyle,
                                      ),
                                      Text('${shops[i].mechnicname}'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // InkWell(
                                //     onTap: () {
                                //       _showDialog();
                                //       if (delrequest)
                                //         shopServices.delBook(shops[i]);
                                //       getshops();
                                //     },
                                //     child: Icon(Icons.delete)),
                              ],
                            ),
                        ],
                    ),
                      )
                    ],),));
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'See All shops available',
                        style: appStyle,
                      ),
                      // Text(
                      //   'View all',
                      //   style: appStyle,
                      // )
                    ],
                  ),
                ),
            //     InkWell(
            //       onTap: () {
            //         AuthService().signOut();
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => SignInPage(),
            //             ));
            //       },
            //       child: Column(
            //         children: <Widget>[
            //           Icon(Icons.lock_open),
            //           Text('Log out'),
            //         ],
            //       ),
            //     )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget enableUpload() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         Image.file(
  //           uploadImage,
  //           height: 308,
  //           width: 308,
  //         )
  //       ],
  //     ),
  //   );
  // }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:mechanicadmin/user/firebase/userServices.dart';
import 'package:mechanicadmin/user/models/shop.dart';
import 'package:mechanicadmin/widgets/common.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class Upload extends StatefulWidget {
  // final Shop shop;

  // const Upload({Key key, this.shop}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
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
  List<Shop> shops = [];
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Shop add',
                    style: subtitle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(.5),
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
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(.5),
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
                    Text(
                      'locate shop here',
                      style: subtitle,
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
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
                            labelText: 'Search shop',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                    // RaisedButton(
                    //   onPressed: getImage,
                    //   child: Text('Choose your file'),
                    // ),
                    // uploadImage == null
                    //     ? Text('Select an Image')
                    //     : enableUpload(),
                    OutlineButton(
                      onPressed: () async {
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
                      child: isLoading
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : Text('save'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'All shops',
                    style: appStyle,
                  ),
                  Text(
                    'View all',
                    style: appStyle,
                  )
                ],
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      for (int i = 0; i < shops.length; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  shops[i].shopName.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  shops[i].address,
                                  style: appStyle,
                                ),
                                Text('${shops[i].shopName}'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  _showDialog();
                                  if (delrequest)
                                    shopServices.delBook(shops[i]);
                                  getshops();
                                },
                                child: Icon(Icons.delete)),
                          ],
                        ),
                    ],
                  ))
            ],
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

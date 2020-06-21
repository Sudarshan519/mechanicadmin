import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mechanicadmin/user/models/shop.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final Position position;
  final int selectedDistance;
  final bool request;
  final List<Shop> shops;
  MapPage(this.position, this.selectedDistance, this.request, this.shops);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BitmapDescriptor myicon, shopicon;
  List<Shop> shops;

  @override
  void initState() {
    super.initState();
    getIcon();
  }

  getDistancec(context) async {
    double distanceInMeters = await Geolocator().distanceBetween(
        widget.position.latitude,
        widget.position.longitude,
        context.latitude,
        context.longitude);
    print(distanceInMeters);
  }

  Marker _buildShopMarker(context, icon) {
    return Marker(
      markerId: MarkerId(context.id),
      icon: icon,
      position: LatLng(context.latitude, context.longitude),
      consumeTapEvents: true,
      infoWindow: InfoWindow(
        title: '${context.address}',
        snippet: "${context.shopName}",
      ),
      onTap: () async {
        //print("Marker tapped");
      },
    );
  }

  // Marker _buildMechanicMarker(context, icon) {
  //   return Marker(
  //     markerId: MarkerId(''),
  //     icon: icon,
  //     position: LatLng(context.latitude, context.longitude),
  //     consumeTapEvents: true,
  //     infoWindow: InfoWindow(
  //       title: '${context.title}',
  //       snippet: "${context.description}",
  //     ),
  //     onTap: () async {
  //       //print("Marker tapped");
  //     },
  //   );
  // }

  Polyline _buildPolyine(context, icon) {
    return Polyline(
        polylineId: PolylineId(context.id),
        color: Colors.blueAccent,
        points: [
          LatLng(widget.position.latitude, widget.position.longitude),
          LatLng(context.latitude, context.longitude)
        ]);
  }

  getsomePoints() async {}

  void getIcon() async {
    myicon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'images/mechanic2.jpeg',
    );
    shopicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/mechanic1.png');
    setState(() {
      //_marker.clear();
      shops = widget.shops;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformMap(
      polylines: widget.request
          ? Set<Polyline>.of([
              _buildPolyine(widget.shops[widget.selectedDistance], shopicon),
              // Polyline(
              //     polylineId: PolylineId('a'),
              //     color: Colors.blueAccent,
              //     points: [
              //       LatLng(_originLatitude, _originLongitude),
              //       LatLng(_marker[0].latitude, _marker[0].longitude)
              //     ])
            ])
          : null,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.position.latitude, widget.position.longitude),
        zoom: 18.0,
      ),
      markers: Set<Marker>.of(
        [
          for (int i = 0; i != widget.shops.length; i++)
            _buildShopMarker(widget.shops[i], shopicon),
          // for (int i = 0; i != _marker.length; i++)
          // _buildMechanicMarker(_marker[i], shopicon),
          Marker(
            markerId: MarkerId('Broke Vehicle'),
            icon: myicon,
            position:
                LatLng(widget.position.latitude, widget.position.longitude),
            consumeTapEvents: true,
            infoWindow: InfoWindow(
              title: 'Sudarshan',
              snippet: "Request repair",
            ),
            onTap: () async {
              //print("Marker tapped");
            },
          )
        ],
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (location) {
        print('onTap: $location');
      },
      mapType: MapType.normal,
      onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
      compassEnabled: true,
      onMapCreated: (controller) {
        Future.delayed(Duration(seconds: 0)).then(
          (_) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  bearing: 270.0,
                  target: 
                  LatLng(
                      widget.position.latitude, widget.position.longitude),
                  tilt: 30.0,
                  zoom: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

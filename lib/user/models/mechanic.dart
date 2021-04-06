import 'package:geolocator/geolocator.dart';

class Mechanic {
  String id;
  String mechnicname;
  double latitude;
  double longitude;
  String address;
  Position mechanicposition;

  Mechanic(this.id, this.mechnicname, this.latitude, this.longitude, this.address);
  factory Mechanic.fromJson(Map<String, dynamic> json) {
    return Mechanic(
      json['id'] as String,
      json['shop_name'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['address'] as String,
    );
  }
}

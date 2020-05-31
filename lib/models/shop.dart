

class Shop {
  String id;
  String shopName;
  double latitude;
  double longitude;
  String address;
  String image;

  Shop(this.id, this.shopName, this.latitude, this.longitude, this.address,this.image);

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      json['id'] as String,
      json['shopName'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['address'] as String,
      json['image'] as String,
    );
  }
  Map<String,dynamic> toJson()=>{
  'id':id,
  'shopName' :shopName,
  'latitude':latitude,
  'longitude':longitude,
  'address':address,
  'image':image,
};
}


class ShopLocation {
  String id;
  double latitude;
  double longitude;
  String title;
  String description;
  String icon;
  String location;

  ShopLocation(this.id, this.latitude, this.longitude, this.title,
      this.description, this.icon);

  factory ShopLocation.fromJson(Map<String, dynamic> json) {
    return ShopLocation(
      json['id'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['title'] as String,
      json['description'] as String,
      json['icon'] as String,
    );
  }
}

final locations = [
  ShopLocation('1', 27.7154, 85.3123, 'ThamelMarker', 'Repair shop at thamel',
      'images/mechanic1.png'),
  ShopLocation('2', 27.7493, 85.3214, 'Gongabu', 'Repair shop at thamel',
      'images/mechanic2.png'),
  ShopLocation('3', 27.6915, 85.3420, 'Baneshor', 'Repair shop at thamel',
      'images/mechanic3.png'),
  // ShopLocation('4', 27.7166, 85.3485, 'Gaushalla', 'Repair shop at thamel', 'images/mechanic4.png'),
];

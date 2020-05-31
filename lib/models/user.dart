class User {
  String id;
  String username;
  String image;
  String email;
  String password;
  String address;
  String vechile;
  String location;
  String serviceCharge;

  User(this.id, this.username, this.image, this.email, this.address,
      this.serviceCharge);
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as String,
      json['username'] as String,
      json['image'] as String,
      json['email'] as String,
      json['address'] as String,
      json['serviceCharge'] as String,
    );
  }
}

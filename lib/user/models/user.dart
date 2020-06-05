class User {
  String id;
  String username;
  String displayName;
  String photoUrl;
  // String image;
  // String email;
  // String password;
  // String address;
  // String vechile;
  // String usertype;
  // String location;
  // String serviceCharge;

  User(this.id, this.displayName,this.photoUrl,
     );
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as String,
      json['displayName'] as String,
      json['photoUrl'] as String,
      // json['email'] as String,
      // json['address'] as String,
      // json['usertype'] as String,
      // json['serviceCharge'] as String,
    );
  }
}

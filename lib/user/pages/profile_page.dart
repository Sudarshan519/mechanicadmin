import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanicadmin/services/authServices.dart';
import 'package:mechanicadmin/signin.dart';
import 'package:mechanicadmin/widgets/common.dart';
import 'package:mechanicadmin/widgets/custom_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseUser user;

 ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotifications = false;
  bool trackLocations = false;
  SharedPreferences preferences;

  final textStyle = new TextStyle(
    fontSize: 16,
  );

  signout() async {
    //AuthService().signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInPage()));
    preferences.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          
          Row(children: <Widget>[
CircleAvatar(backgroundImage: AssetImage('images/a.jpg'),
),
Column(children: <Widget>[
  Text(widget.user.email)
],),
Icon(Icons.settings)
          ],),
          Row(children: <Widget>[
            Icon(Icons.arrow_forward_ios)

          ],),
          // Text(
          //   "Profile",
          //   style:
          //       textStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
          // ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: Colors.red,
                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 3.0,
                    //     offset: Offset(0, 4),
                    //     color: Colors.black38,
                    //   ),
                    // ],
                    image: DecorationImage(
                      image: AssetImage(
                        "images/a.jpg",
                      ),
                      fit: BoxFit.cover,
                    )),
                //child:Image.asset("assets/images/pizza.jpg",fit: BoxFit.cover,)
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.user.displayName,
                    style:heading,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.user.email,
                  softWrap: true,
                    style: subtitle.copyWith(fontSize:18)
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 25,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          )),
                      child: Center(
                          child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Account",
            style:
                textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Samakhushi 02,Kathmandu"),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  CustomListTile(Icons.location_on, "Loading"),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  CustomListTile(Icons.visibility, "Change Password"),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  CustomListTile(Icons.shopping_cart, "Shipping"),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  CustomListTile(Icons.payment, "PayMent"),
                  // Padding(
                  //   padding: const EdgeInsets.all(5.0),
                  //   child: ListTile(
                  //     leading: Icon(Icons.location_on),
                  //     title: Text("Location"),
                  //     subtitle: Text("Something"),
                  //     trailing: Icon(Icons.location_off),
                  //   ),
                  // ),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Location"),
                    ],
                  ),

                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10)
                  // ListTile(
                  //   leading: Icon(Icons.location_on),
                  //   title: Text("Location"),
                  //   subtitle: Text("Something"),
                  //   trailing: Icon(Icons.location_off),
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.location_on),
                  //   title: Text("Location"),
                  //   subtitle: Text("Something"),
                  //   trailing: Icon(Icons.location_off),
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.location_on),
                  //   title: Text("Location"),
                  //   subtitle: Text("Something"),
                  //   trailing: Icon(Icons.location_off),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Card(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("App Notifications"),
                        Switch(
                            value: turnOnNotifications,
                            onChanged: (bool value) {
                              setState(() {
                                turnOnNotifications = value;
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Location Tracking"),
                        Switch(
                            value: trackLocations,
                            onChanged: (bool value) {
                              setState(() {
                                trackLocations = value;
                              });
                            })
                      ],
                    ),
                  ],
                )),
          ),
          SizedBox(height: 20),
          Text(
            "Other",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Language",
                      style: TextStyle(fontSize: 15),
                    ),
                    RaisedButton(
                      onPressed: () {
                        AuthService().signOut();
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SignInPage();
                        }));
                      },
                      child: Text('Sign out'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

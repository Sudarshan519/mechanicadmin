import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanicadmin/business/orders.dart';
import 'package:mechanicadmin/business/shops.dart';
import 'package:mechanicadmin/services/authServices.dart';
import 'package:mechanicadmin/signin.dart';
import 'package:mechanicadmin/widgets/common.dart';

class BusinessHomePage extends StatefulWidget {
  final FirebaseUser user;
  BusinessHomePage(this.user);

  @override
  _BusinessHomePageState createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width * .7,
        child: Drawer(
            child: Container(
          color: Colors.green,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: widget.user != null
                    ? Text(widget.user.displayName ?? '')
                    : null,
                accountEmail:
                    widget.user != null ? Text(widget.user.email) : Text(''),
                currentAccountPicture: InkWell(
                  //onTap: () => updateImage(),
                  child: CircleAvatar(
                    //backgroundImage: AssetImage,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.person_add)),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AddShop();
                  }));
                },
                leading: Text(
                  'Orders',
                  style: title,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AddShop();
                  }));
                },
                leading: Text(
                  'Products',
                  style: title,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AddShop();
                  }));
                },
                leading: Text(
                  'Customers',
                  style: title,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AddShop();
                  }));
                },
                leading: Text(
                  'Add shop',
                  style: title,
                ),
              ),
              ListTile(
                onTap: () {
                  AuthService().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SignInPage();
                  }));
                },
                leading: Text(
                  'logout',
                  style: title,
                ),
                title: Icon(Icons.lock_open),
              )
            ],
          ),
        )),
      ),
      body: Container(
        //margin: EdgeInsets.all(1),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(30),
          color: Colors.green,
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                  Text(
                    'Daily Sales Record',
                    style: heading.copyWith(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  Icon(
                    Icons.help_outline,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.autorenew,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Divider(),
            // Container(
            //   height: MediaQuery.of(context).size.height * .1,
            //   child: LineChart(),

            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Expanded(
                child: GridView(
              padding: EdgeInsets.all(0),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => OrderPage()));
                    },
                    title: Icon(
                      Icons.assignment,
                      size: 100,
                    ),
                    subtitle: Text(
                      'Orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                ListTile(
                    title: Icon(
                      Icons.library_add,
                      size: 100,
                    ),
                    subtitle: Text(
                      'Products',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                ListTile(
                    title: Icon(
                      Icons.attach_money,
                      size: 80,
                    ),
                    subtitle: Text(
                      'Sales',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                ListTile(
                    title: Icon(
                      Icons.insert_chart,
                      size: 80,
                    ),
                    subtitle: Text(
                      'Reports',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                ListTile(
                    title: Icon(
                      Icons.people,
                      size: 80,
                    ),
                    subtitle: Text(
                      'Customers',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Scaffold(
                                    body: Column(
                                      children: <Widget>[],
                                    ),
                                  )));
                    },
                    title: Icon(
                      Icons.person,
                      size: 80,
                    ),
                    subtitle: Text(
                      'Mechanic',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

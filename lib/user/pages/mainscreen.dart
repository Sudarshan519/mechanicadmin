import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanicadmin/user/pages/homepage.dart';
import 'package:mechanicadmin/user/pages/profile_page.dart';
import 'package:mechanicadmin/user/pages/repairs.dart';
import 'package:mechanicadmin/widgets/common.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser user;
  MainScreen(this.user);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;
  HomePage homePage;
  Repairs repairPage;
  ProfilePage profilePage;
  bool searchpressed = false;
  //User get user => null;
  @override
  void initState() {
    super.initState();
    homePage = HomePage(widget.user);
    repairPage = Repairs();
    profilePage = ProfilePage(widget.user);
    pages = [homePage, repairPage, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            currentIndex: currentTabIndex,
            onTap: (int index) {
              setState(() {
                currentTabIndex = index;
                currentPage = pages[index];
              });
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Colors.blueGrey,), title: Text("Home",style: subtitle,)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.build,color: Colors.blueGrey,), title: Text("Repairs",style: subtitle,)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: Colors.blueGrey), title: Text("Profile",style: subtitle,)),
            ]));
  }
}

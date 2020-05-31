
import 'package:flutter/material.dart';

import 'package:mechanicadmin/models/user.dart';
import 'package:mechanicadmin/pages/homepage.dart';

import 'package:mechanicadmin/pages/profile_page.dart';
import 'package:mechanicadmin/pages/repairPage.dart';


class MainScreen extends StatefulWidget {
  final String username;
  MainScreen(this.username);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;
  HomePage homePage;
  RepairPage repairPage;
  //SignupPage signupPage;
  ProfilePage profilePage;
  bool searchpressed = false;
  User get user => null;
  @override
  void initState() {
    super.initState();
    homePage = HomePage(widget.username);

    repairPage = RepairPage();
    //signupPage = SignupPage();
    profilePage = ProfilePage();
    pages = [homePage, repairPage, profilePage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
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
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.build), title: Text("Repairs")),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.favorite), title: Text("favourites")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile")),
            ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechanicadmin/rtd.dart';

import 'widgets/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setEnabledSystemUIOverlays([]);
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (_) => SplashScreen(),

      },
      initialRoute: '/',
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool signedin = true;

//   @override
//   Widget build(BuildContext context) {
//     return signedin == false ? SignInPage() : MainScreen();
//   }
// }

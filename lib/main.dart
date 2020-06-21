import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
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


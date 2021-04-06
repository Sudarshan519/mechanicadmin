import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mechanicadmin/services/authServices.dart';
import 'package:mechanicadmin/user/pages/welcome.dart';

import 'user/pages/home.dart';
import 'widgets/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (_) =>
            authService.auth.currentUser() != null ? Home() : WelcomePage(),
      },
      initialRoute: '/',
    );
  }
}

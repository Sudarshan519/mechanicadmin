import 'package:flutter/material.dart';

final headingStyle = TextStyle(color: Colors.white, fontSize: 20);
final titleStyle = TextStyle(color: Colors.white70, fontSize: 18);
final subtitleStyle = TextStyle(color: Colors.white60, fontSize: 12);

final Color kPrimaryColor = Colors.red.shade900;
final Color kShadowColor = Colors.grey.withOpacity(.2);
final Color kBlackColor = Colors.white12;
final Color kSubtitleColor = Colors.white54;
final Color kSecondaryColor = Colors.grey;
final Color kBorderColor = Colors.grey;

final TextStyle kTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

final TextStyle kDescriptionStyle = TextStyle(
  color: kSubtitleColor,
  fontSize: 13,
);

class SpaceBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}

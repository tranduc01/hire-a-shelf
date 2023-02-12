import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = const Duration(seconds: 2);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return WelcomeScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 221, 214),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [splashScreenIcon(), welcomeTextWidget()],
      )),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/icons/splash_screen_icon.svg";
  return SvgPicture.asset(
    iconPath,
    height: 70,
    width: 70,
  );
}

Widget welcomeTextWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      AppText(
        text: "Hire a Shelf",
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 8, 38, 12),
      ),
      // AppText(
      //   text: "a Shelf",
      //   fontSize: 48,
      //   fontWeight: FontWeight.w600,
      //   color: Color.fromARGB(255, 8, 38, 12),
      // ),
    ],
  );
}

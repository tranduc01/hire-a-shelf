import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "assets/images/welcome_image.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            SizedBox(
              height: 20,
            ),
            welcomeTextWidget(),
            SizedBox(
              height: 10,
            ),
            sloganText(),
            SizedBox(
              height: 40,
            ),
            getButton(context),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    ));
  }

  // Widget icon() {
  //   String iconPath = "assets/icons/app_icon.svg";
  //   return SvgPicture.asset(
  //     iconPath,
  //     width: 60,
  //     height: 60,
  //     color: Color.fromARGB(255, 233, 228, 220),
  //   );
  // }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 8, 38, 12),
        ),
        AppText(
          text: "to our store",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 8, 38, 12),
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "Create or Join canpaign now !!!",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 8, 32, 12).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Get Started",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onGetStartedClicked(context);
      },
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return DashboardScreen();
      },
    ));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';

class About extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Container(
        child: Center(
          child : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                        height: 35,
                      ),
                  homeScreenIcon(),
                  ListTile(
                    title: AppText(
                      text: "About",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    fontSize: 20,
                    textAlign: TextAlign.center,  
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  aboutPhoto(),
                  SizedBox(
                    height: 10,
                  ),
                  AppText(
                    text:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    fontSize: 20,
                    textAlign: TextAlign.center,  
                  )
                ],
              ),
          ),    
        ),
      ),
    );
  }
  Widget homeScreenIcon() {
    String iconPath = "assets/icons/splash_screen_icon.svg";
    return SvgPicture.asset(
      iconPath,
      height: 60,
      width: 60,
    );
  }
  
  Widget aboutPhoto() {
    String iconPath = "assets/icons/splash_screen_icon.svg";
    return SvgPicture.asset(
      iconPath,
      height: 300,
      width: 300,
    );
  }
  
}
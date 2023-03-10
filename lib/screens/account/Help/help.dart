import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/account/Help/help_item.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              child : SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(),
                    ),
                    homeScreenIcon(),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: AppText(
                        text: "Help",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      subtitle: AppText(
                        text:
                            'IF YOU HAD ANY PROBLEMS, PLEASE CONTACT WITHIN THE INFORMATION BELOW.',
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: getChildrenWithSeperator(
                        widgets: helpItems.map((e) {
                          return getHelpItemWidget(e);
                        }).toList(),
                        seperator: Divider(
                          thickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      )
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

  Widget getHelpItemWidget(HelpItem helpItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/account_icons/phone_icon.svg",width: 21, height: 21),
          SizedBox(
            width: 5,
          ),
          Text(
            ": " + helpItem.tel,
            style: TextStyle(fontSize: 18)
          ),
          SizedBox(
            width: 30,
          ),
          SvgPicture.asset("assets/icons/account_icons/email_icon.svg",width: 21, height: 21),
          SizedBox(
            width: 5,
          ),
          Text(
            ": " + helpItem.email,
            style: TextStyle(fontSize: 18)
          ),
        ],
      ),
    );
  }
}

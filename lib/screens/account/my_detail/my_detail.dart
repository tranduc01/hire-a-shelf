import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/account/my_detail/my_detail_item.dart';

class MyDetail extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center (
          child: Column(
            children: [
              SizedBox(
                    height:35,
                  ),
              homeScreenIcon(),
              ListTile(
                title: AppText(
                  text: "My Detail",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: getChildrenWithSeperator(
                  widgets: myDetailItems.map((e) {
                    return getMyDetailItemWidget(e);
                  }).toList(),
                  seperator: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
        )
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
  
  Widget getMyDetailItemWidget(MyDetailItem myDetailItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 20,
            child: Text(
              myDetailItem.label,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            myDetailItem.detail,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/styles/colors.dart';

import 'account_item.dart';
import 'detail_screen.dart';

class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading:
                    SizedBox(width: 65, height: 65, child: getImageHeader()),
                title: AppText(
                  text: "Mohammed Hashim",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AppText(
                  text: "github.com/mohammedhashim44",
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: accountItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(width: 20, height: 20, child: SvgPicture.asset(accountItems[index].iconPath)),
                    title: Text(accountItems[index].label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(accountItem: accountItems[index]),
                          ),
                      );
                    }
                  );
                }
              ),
              SizedBox(
                height: 20,
              ),
              logoutButton(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  // Widget getAccountItemWidget(BuildContext context) {
  //   return Container(
  //     child: ListView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: accountItems.length,
  //                   itemBuilder: (context, index) {
  //                     return ListTile(
  //                       leading: SizedBox(width: 20, height: 20, child: SvgPicture.asset(accountItems[index].iconPath)),
  //                       title: Text(accountItems[index].label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //                       trailing: Icon(Icons.arrow_forward_ios),
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (context) => DetailScreen(accountItem: accountItems[index]),
  //                           ),
  //                       );
  //                   }
  //                 );
  //               }
  //     ),
  //   );
  // }
  
}



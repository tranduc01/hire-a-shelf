//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/notifications/notificationItem.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
          child : Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: AppText(
                  text: "Notifications",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              // Text(
              //   'No Notifications',
              //   style: const TextStyle(fontWeight: FontWeight.w600,color: Color(0xFF7C7C7C)),
              //   textAlign: TextAlign.center,
              SingleChildScrollView(
              child : Column(
                children: getChildrenWithSeperator(
                  widgets: notiItem.map((e) {
                    return getNotificationItemWidget(e);
                  }).toList(),
                  seperator: Divider(
                    thickness: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

Widget getNotificationItemWidget(NotificationItem notiItem) {
  return Container(
      margin: EdgeInsets.symmetric(),
      padding: EdgeInsets.symmetric(),
      child : Row(
        children: [
          Expanded(
          child :Card(
            child : ListTile(
                title: Text(
                  notiItem.title, 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  notiItem.detail,
                  style:  TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }


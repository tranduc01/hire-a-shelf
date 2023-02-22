//import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/notifications/notificationItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  Future<List<NotificationItem>>? notifications;
  int _id = 0;
  String _jwt = "";
  @override
  void initState() {
    super.initState();
    _refreshData();
    Timer.periodic(Duration(seconds: 4), (Timer t) => _refreshData());
    loadID();
    loadJwt();
  }

  loadID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _id = preferences.getInt("accountId") ?? 0;
    });
  }

  loadJwt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _jwt = preferences.getString("token") ?? "";
    });
  }

  void _refreshData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _id = preferences.getInt("accountId") ?? 0;
    var newNotifications = fetchNotificationByAccountId(_id);
    setState(() {
      notifications = newNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Notifications",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListTile(
                  //   title: AppText(
                  //     text: "Notifications",
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  (_jwt == "")
                      ? Text(
                          'No Notifications',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7C7C7C)),
                          textAlign: TextAlign.center,
                        )
                      : getNotifications(notifications!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget getNotificationItemWidget(NotificationItem notiItem) {
  return Container(
    margin: EdgeInsets.symmetric(),
    padding: EdgeInsets.symmetric(),
    child: Row(
      children: [
        Expanded(
          child: Card(
            child: ListTile(
              title: Text(
                notiItem.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                notiItem.body,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget getNotifications(Future<List<NotificationItem>> nodifications) {
  return FutureBuilder<List<NotificationItem>>(
    future: nodifications,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<NotificationItem> notifications = snapshot.data!;
        List<NotificationItem> reverse = notifications.reversed.toList();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: reverse.length,
          itemBuilder: (context, index) {
            var item = reverse[index];
            return (reverse.isEmpty)
                ? Text(
                    'No Notifications',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xFF7C7C7C)),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: getChildrenWithSeperator(
                      widgets: [getNotificationItemWidget(item)],
                      seperator: Divider(
                        thickness: 1,
                      ),
                    ),
                  );
          },
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

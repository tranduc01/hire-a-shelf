//import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/notifications/notificationItem.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin {
  Future<List<NotificationItem>>? notifications;
  String _jwt = "";
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void didUpdateWidget(covariant NotificationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshData();
  }

  @override
  bool get wantKeepAlive => true;

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  Future<void> _refreshData() async {
    var id = await readFromStorage("accountId");
    var jwt = await readFromStorage("token");
    if (jwt != null) {
      var newNotifications = fetchNotificationByAccountId(int.parse(id!));
      setState(() {
        _jwt = jwt;
        notifications = newNotifications;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RefreshIndicator(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    (_jwt == "")
                        ? Container(
                            height: 600,
                            child: Text(
                              'No Notifications',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7C7C7C)),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : getNotifications(notifications!),
                  ],
                ),
              ),
            ),
            onRefresh: () => _refreshData(),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
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
          physics: BouncingScrollPhysics(),
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

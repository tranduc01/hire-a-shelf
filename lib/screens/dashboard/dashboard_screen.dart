import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../account/account_screen.dart';
import '../mycampaign_screen.dart';
import '../home/home_screen.dart';
import '../notifications/notificationItem.dart';
import '../notifications/notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context, screens: screens(), items: navBarItems(),
          onItemSelected: (index) {
        if (index == 2) {
          setState(() {
            print("Refresh noti screen");
          });
        } else if (index == 1) {
          setState(() {
            print("Refresh my campaign screen");
          });
        } else if (index == 0) {
          setState(
            () {
              print("Refresh my home screen");
            },
          );
        } else {
          setState(() {
            print("Refresh my account screen");
          });
        }
      },
          resizeToAvoidBottomInset: true,
          popActionScreens: PopActionScreensType.all,
          confineInSafeArea: true,
          stateManagement: true,
          navBarStyle: NavBarStyle.style9),
    );
  }

  List<Widget> screens() {
    return [
      HomeScreen(),
      MyCampaignScreen(),
      NotificationScreen(),
      AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: Colors.black,
        inactiveColorSecondary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.pencil_outline),
          title: "Campaign",
          activeColorPrimary: Colors.black,
          inactiveColorSecondary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bell),
          title: "Notification",
          activeColorPrimary: Colors.black,
          inactiveColorSecondary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          title: "Account",
          activeColorPrimary: Colors.black,
          inactiveColorSecondary: CupertinoColors.systemGrey),
    ];
  }
}

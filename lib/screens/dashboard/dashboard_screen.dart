import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../account/account_screen.dart';
import '../mycampaign_screen.dart';
import '../home/home_screen.dart';
import '../notifications/notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(context,
          screens: screens(),
          items: navBarItems(),
          resizeToAvoidBottomInset: true,
          popAllScreensOnTapOfSelectedTab: true,
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

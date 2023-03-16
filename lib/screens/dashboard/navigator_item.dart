import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/screens/my_campaign/mycampaign_screen.dart';
import 'package:grocery_app/screens/home/home_screen.dart';

import '../notifications/notification_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Home", "assets/icons/shop_icon.svg", 0, HomeScreen()),
  NavigatorItem(
      "My Campaingn", "assets/icons/explore_icon.svg", 1, MyCampaignScreen()),
  NavigatorItem("Notifications", "assets/icons/notification_icon.svg", 2,
      NotificationScreen()),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 3, AccountScreen()),
];

import 'package:flutter/material.dart';
import 'package:grocery_app/screens/account/my_detail/my_detail.dart';

import 'about.dart';
import 'Help/help.dart';

class AccountItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  AccountItem(this.label, this.iconPath, this.index,this.screen);
}

List<AccountItem> accountItems = [
  AccountItem("My Details", "assets/icons/account_icons/details_icon.svg", 0, MyDetail()),
  AccountItem("Help", "assets/icons/account_icons/help_icon.svg", 1, Help()),
  AccountItem("About", "assets/icons/account_icons/about_icon.svg", 2, About()),
];

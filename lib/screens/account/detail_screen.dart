
import 'package:flutter/material.dart';

import 'account_item.dart';

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo
  final AccountItem accountItem;

  // In the constructor, require a Todo
  DetailScreen({Key? key, required this.accountItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      body: accountItem.screen
    );
  }
}
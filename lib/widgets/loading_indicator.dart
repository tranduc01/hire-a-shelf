import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: 350,
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/sending.gif",
                  height: 300,
                ),
                Text(
                  "Please wait.....",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }
}

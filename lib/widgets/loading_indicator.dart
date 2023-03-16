import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
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
                  "Hang on.....",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          )),
    );
  }
}

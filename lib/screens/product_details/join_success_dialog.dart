import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';

class JoinSuccessDialouge extends StatefulWidget {
  JoinSuccessDialouge({Key? key}) : super(key: key);
  @override
  _JoinSuccessDialougeSate createState() => _JoinSuccessDialougeSate();
}

class _JoinSuccessDialougeSate extends State<JoinSuccessDialouge> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        height: 600.0,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Image.asset("assets/images/successful.gif")),
            Spacer(
              flex: 5,
            ),
            AppText(
              text: "Yay ! Join Successfully",
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            Spacer(
              flex: 4,
            ),
            AppText(
              text: "You can follow up your application at My Campaign",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff7C7C7C),
            ),
            Spacer(
              flex: 8,
            ),
            AppButton(
              label: "Back To Home",
              fontWeight: FontWeight.w600,
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DashboardScreen();
                  },
                ));
              },
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}

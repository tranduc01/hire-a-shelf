import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/account.dart';
import 'account_item.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  final token;
  Account? account;
  AccountScreen({this.token, this.account, Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      if (JwtDecoder.isExpired(widget.token)) {
        _isVisible = false;
      } else {
        _isVisible = true;
      }
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                (widget.token != null)
                    ? ((JwtDecoder.isExpired(widget.token))
                        ? getHeaderNotLogin()
                        : getHeaderWidget())
                    : getHeaderNotLogin(),
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems.map((e) {
                      return getAccountItemWidget(e);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 390,
                ),
                Visibility(visible: _isVisible, child: logoutButton()),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 219, 218, 231),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
                color: Color.fromARGB(255, 226, 21, 21),
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 226, 21, 21)),
            ),
            Container()
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Logging Out",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text("Are you sure want to log out?"),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ));
                      },
                      child: Text("Log Out"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                  ElevatedButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontWeight: FontWeight.w600)))
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: Color.fromARGB(255, 65, 105, 255).withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  Widget getHeaderWidget() {
    return ListTile(
      leading: SizedBox(width: 65, height: 65, child: getImageHeader()),
      title: AppText(
        text: (widget.account!.brand != null)
            ? (widget.account!.brand!.name)
            : (widget.account!.store != null)
                ? (widget.account!.store!.name)
                : (widget.account!.username),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      subtitle: AppText(
        text: widget.account!.email,
        color: Color(0xff7C7C7C),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      onTap: () {
        print(widget.account?.brand?.name);
        print(widget.account?.store?.name);
        print(widget.account?.admin?.address);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );
  }

  Widget getHeaderNotLogin() {
    return ListTile(
      leading: SizedBox(width: 65, height: 65, child: getImageHeader()),
      title: AppText(
        text: "Login",
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      subtitle: AppText(
        text: "Hire a Shelf",
        color: Color(0xff7C7C7C),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
  }
}

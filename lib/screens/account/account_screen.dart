import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../constraints/constraints.dart';
import '../../models/account.dart';
import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  int _id = 0;
  String _jwt = "";

  final storage = new FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    super.initState();
    loadJwt();
  }

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  loadJwt() async {
    String? token = await readFromStorage("token");
    if (token != null) {
      String? id = await readFromStorage("accountId");
      setState(() {
        _jwt = token;
        _id = int.parse(id!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant AccountScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadJwt();
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
                (_jwt != "")
                    ? ((JwtDecoder.isExpired(_jwt))
                        ? getHeaderNotLogin()
                        : getHeaderWidget(_id, _jwt))
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
                  height: 350,
                ),
                Visibility(
                    visible: (_jwt != "")
                        ? ((JwtDecoder.isExpired(_jwt)) ? false : true)
                        : false,
                    child: logoutButton()),
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
                // ignore: deprecated_member_use
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
                      onPressed: () async {
                        var fcmToken;
                        await FirebaseMessaging.instance
                            .getToken()
                            .then((token) {
                          fcmToken = token;
                        });
                        var response = await http.post(
                          Uri.parse("$BASE_URL/auth/logout"),
                          body: jsonEncode(
                              {"accountId": _id, "firebaseToken": fcmToken}),
                          headers: {'Content-Type': "application/json"},
                        );
                        if (response.statusCode == 200) {
                          await storage.deleteAll();
                          await _googleSignIn.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ));
                        } else {
                          print(response.statusCode);
                        }
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

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => accountItem.screen,
              ),
            );
          },
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
        ));
  }

  Widget getHeaderWidget(int id, String token) {
    return FutureBuilder<Account>(
      future: fetchAccountById(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var account = snapshot.data;
          String imagePath = "";
          if (token != "") {
            if (JwtDecoder.isExpired(token)) {
              imagePath =
                  "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4";
            } else {
              (account!.brand != null)
                  ? imagePath = (account.brand!.logo) ??
                      "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4"
                  : (account.store != null)
                      ? imagePath = (account.store!.logo) ??
                          "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4"
                      : imagePath =
                          ("https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Fadmin.jpg?alt=media&token=53ed88fe-bd99-44d6-86af-04a3fe2031a2");
            }
          } else {
            imagePath =
                "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4";
          }
          return ListTile(
            leading: SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  radius: 5.0,
                  backgroundImage: NetworkImage(imagePath),
                  backgroundColor:
                      Color.fromARGB(255, 65, 105, 255).withOpacity(0.7),
                )),
            title: AppText(
              text: (account!.brand != null)
                  ? (account.brand!.name)
                  : (account.store != null)
                      ? (account.store!.name)
                      : (account.username),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            subtitle: AppText(
              text: account.email,
              color: Color(0xff7C7C7C),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            onTap: () {
              print(account.id);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getHeaderNotLogin() {
    return ListTile(
      leading: SizedBox(
          width: 65,
          height: 65,
          child: CircleAvatar(
            radius: 5.0,
            backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4"),
            backgroundColor: Color.fromARGB(255, 65, 105, 255).withOpacity(0.7),
          )),
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

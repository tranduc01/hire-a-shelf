import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/account.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  late SharedPreferences prefs;
  String? fcmToken = "";
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void updateVisible() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void login(String username, String password) async {
    // var response = await http.post(
    //   Uri.parse("https://hireashelf.up.railway.app/api/auth"),
    //   body: jsonEncode({"userName": username, "password": password}),
    //   headers: {'Content-Type': "application/json"},
    // );
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
    });
    var response = await http.post(
      Uri.parse("http://10.0.2.2:9090/api/auth"),
      body: jsonEncode({
        "userName": username,
        "password": password,
        "firebaseToken": fcmToken
      }),
      headers: {'Content-Type': "application/json"},
    );
    var responseJson = jsonDecode(response.body);
    //var myToken = responseJson['token'];
    if (responseJson['status'] == 200) {
      Account account = Account.fromJson(responseJson['account']);
      prefs.setString('token', responseJson['token']);
      prefs.setInt("accountId", account.id);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountScreen(),
          ));
      // Navigator.of(context, rootNavigator: true).push(
      //   MaterialPageRoute(
      //     builder: (_) => AccountScreen(),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(
        msg: "Invalid Username or Password !!!",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: homeScreenIcon(),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Row(
                  children: [
                    AppText(
                      text: "Login",
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text(
                      "Enter your email and password",
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 17,
                ),
                loginForm(),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 17),
                    )
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                loginButton(context),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Don't have an account? Sign up here",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Or connect with",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                loginGoogleButton()
              ]),
            )
          ]),
        ),
      )),
    );
  }

  Widget homeScreenIcon() {
    String iconPath = "assets/icons/splash_screen_icon.svg";
    return SvgPicture.asset(
      iconPath,
      height: 100,
      width: 100,
    );
  }

  Widget loginForm() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(5))),
            labelText: "Username",
            labelStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: passwordController,
          obscureText: _isObscure,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                updateVisible();
              },
              child: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(5))),
            labelText: "Password",
            labelStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget loginButton(BuildContext context) {
    return AppButton(
      label: "Login",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () async {
        if (usernameController.text.isEmpty ||
            passwordController.text.isEmpty) {
          Fluttertoast.showToast(
            msg: "Invalid Username or Password !!!",
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          login(usernameController.text.trim(), passwordController.text.trim());
        }
      },
    );
  }

  Widget loginGoogleButton() {
    return AppButton(
      label: "Continue with Google",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DashboardScreen(),
        //     ));
      },
    );
  }
}

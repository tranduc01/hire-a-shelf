import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:http/http.dart' as http;
import '../models/account.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  final storage = new FlutterSecureStorage();
  String? fcmToken = "";

  @override
  void initState() {
    super.initState();
  }

  void updateVisible() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void login(String username, String password) async {
    var response = await http.post(
      Uri.parse("https://hireashelf.up.railway.app/api/auth"),
      body: jsonEncode({"userName": username, "password": password}),
      headers: {'Content-Type': "application/json"},
    );
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
    });
    // var response = await http.post(
    //   Uri.parse("http://10.0.2.2:8080/api/auth"),
    //   body: jsonEncode({
    //     "userName": username,
    //     "password": password,
    //     "firebaseToken": fcmToken
    //   }),
    //   headers: {'Content-Type': "application/json"},
    // );
    //var myToken = responseJson['token'];
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      Account account = Account.fromJson(responseJson['account']);
      await storage.write(key: 'token', value: responseJson['token']);
      await storage.write(key: "accountId", value: account.id.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountScreen(),
          ));
    } else {
      print(response.statusCode);
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

  Future<void> logInGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      var idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      // print(idToken!.substring(0, 1000));
      // print(idToken.substring(1000));
      if (result.user != null) {
        await FirebaseMessaging.instance.getToken().then((token) {
          setState(() {
            fcmToken = token;
          });
        });
        var response = await http.post(
            //Uri.parse("http://10.0.2.2:8080/api/auth/google"),
            Uri.parse("https://hireashelf.up.railway.app/api/auth/google"),
            body: {"idToken": idToken, "firebaseToken": fcmToken});
        //var myToken = responseJson['token'];
        print(response.statusCode);
        if (response.statusCode == 200) {
          var responseJson = jsonDecode(response.body);
          Account account = Account.fromJson(responseJson['account']);
          await storage.write(key: 'token', value: responseJson['token']);
          await storage.write(key: "accountId", value: account.id.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ));
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
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(),
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
    return GestureDetector(
      onTap: () {
        logInGoogle();
      },
      child: SvgPicture.asset(
        "assets/icons/google-icon.svg",
        height: 50,
        width: 50,
      ),
    );
  }
}

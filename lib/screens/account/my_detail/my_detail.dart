import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/account.dart';

class MyDetail extends StatefulWidget {
  @override
  State<MyDetail> createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  int _id = 0;
  String _jwt = "";
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    loadID();
    loadJwt();
  }

  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  loadID() async {
    String? id = await readFromStorage("accountId");
    if (id != null) {
      int i = int.parse(id);
      setState(() {
        _id = i;
      });
    } else {
      setState(() {
        _id = 0;
      });
    }
  }

  loadJwt() async {
    String? token = await readFromStorage("token");
    if (token != null) {
      setState(() {
        _jwt = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: BackButton(),
        ),
        Flexible(
          child: (_jwt != "")
              ? getMyDetailItemWidget(_id)
              : Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background-error.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please login !!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your Session has been expired',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
        )
      ],
    ))));
  }

  Widget avatarImage(String iconPath) {
    return Image.network(
      iconPath,
      height: 120,
      width: 120,
      fit: BoxFit.cover,
    );
  }

  Widget getMyDetailItemWidget(int id) {
    return FutureBuilder<Account>(
      future: fetchAccountById(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var account = snapshot.data;
          String imagePath = "";
          (account!.brand != null)
              ? imagePath = (account.brand!.logo) ??
                  "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4"
              : (account.store != null)
                  ? imagePath = (account.store!.logo) ??
                      "https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Faccount.png?alt=media&token=a960c284-3728-4120-99cf-bd3b838328d4"
                  : imagePath =
                      ("https://firebasestorage.googleapis.com/v0/b/hire-a-shelf.appspot.com/o/resoures%2Fadmin.jpg?alt=media&token=53ed88fe-bd99-44d6-86af-04a3fe2031a2");
          return Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  avatarImage(imagePath),
                  ListTile(
                    title: AppText(
                      text: "My Detail",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Username",
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        account.username,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Email",
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          account.email,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Name",
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        (account.brand != null)
                            ? (account.brand!.name)
                            : (account.admin != null)
                                ? "admin"
                                : (account.store!.name),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Phone",
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        (account.brand != null)
                            ? (account.brand!.phone)
                            : (account.admin != null)
                                ? account.admin!.phone
                                : (account.store!.phone),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

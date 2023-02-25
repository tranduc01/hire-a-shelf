import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:grocery_app/models/campaign_product.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'join_success_dialog.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Campaign campaign;
  final String? heroSuffix;

  const ProductDetailsScreen(this.campaign, {this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isIconDetail = false;
  bool _isIconDuration = false;
  bool _isVisible = false;
  bool _isVisibleDuration = false;

  String _jwt = "";
  @override
  void initState() {
    super.initState();
    loadJwt();
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void showToastDuration() {
    setState(() {
      _isVisibleDuration = !_isVisibleDuration;
    });
  }

  loadJwt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _jwt = preferences.getString("token") ?? "";
    });
  }

  createContract(int campaignId, int storeId) async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2:9090/api/contract"),
      body: jsonEncode({"campaignId": campaignId, "storeId": storeId}),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderFailedDialogue();
          });
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              getImageHeaderWidget(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                widget.campaign.title,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: AppText(
                                    text: widget.campaign.content,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff7C7C7C),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Contact",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(thickness: 1),
                            getProductDetailsWidget(),
                            getProducts(),
                            Divider(thickness: 1),
                            getExpiredDate(customWidget: expiredDateWidget()),
                            Divider(thickness: 1),
                            getDurationWidget(customWidget: durationWidget()),
                            getDuration(),
                            SizedBox(
                              height: 10,
                            ),
                            joinButton(_jwt),
                            Spacer(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageHeaderWidget() {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Hero(
        tag: "GroceryItem:" +
            widget.campaign.title +
            "-" +
            (widget.heroSuffix ?? ""),
        child: Image(
          image: NetworkImage(widget.campaign.imgURL),
        ),
      ),
    );
  }

  Widget getProducts() {
    return FutureBuilder<List<CampaignProduct>>(
      future: fetchProductByCampaignId(widget.campaign.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CampaignProduct> campaigns =
              snapshot.data as List<CampaignProduct>;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                var item = campaigns[index];
                return Row(
                  children: [
                    Visibility(
                        visible: _isVisible,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Image.network(
                            item.product.imgURL,
                            height: 80,
                            width: 80,
                          ),
                        )),
                    Spacer(),
                    Visibility(
                        visible: _isVisible,
                        child: AppText(text: item.product.name)),
                  ],
                );
              });
        } else {
          print(snapshot.error.toString());
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getDuration() {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Row(children: [
              Visibility(
                  visible: _isVisibleDuration,
                  child: AppText(
                      text: "From", fontWeight: FontWeight.w600, fontSize: 16)),
              SizedBox(
                height: 5,
                width: 210,
              ),
              Visibility(
                  visible: _isVisibleDuration,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AppText(
                      text: DateFormat("dd/MM/yyyy")
                          .format(widget.campaign.startDate),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xff7C7C7C),
                    ),
                  ))
            ]),
            SizedBox(
              height: 5,
            ),
            Row(children: [
              Visibility(
                  visible: _isVisibleDuration,
                  child: AppText(
                      text: "To", fontWeight: FontWeight.w600, fontSize: 16)),
              SizedBox(
                height: 5,
                width: 230,
              ),
              Visibility(
                  visible: _isVisibleDuration,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AppText(
                      text: DateFormat("dd/MM/yyyy")
                          .format(widget.campaign.expirationDate),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xff7C7C7C),
                    ),
                  ))
            ]),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          AppText(text: label, fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          Icon(Icons.arrow_back_ios),
        ],
      ),
    );
  }

  Widget getExpiredDate({Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          AppText(
              text: "Expired Date", fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
        ],
      ),
    );
  }

  Widget getProductDetailsWidget({Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          AppText(
              text: "Product Details",
              fontWeight: FontWeight.w600,
              fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                  _isIconDetail = !_isIconDetail;
                });
              },
              icon: iconChange(_isIconDetail)),
        ],
      ),
    );
  }

  Widget getDurationWidget({Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          AppText(text: "Duration", fontWeight: FontWeight.w600, fontSize: 16),
          Spacer(),
          if (customWidget != null) ...[
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          IconButton(
            onPressed: () {
              setState(() {
                _isVisibleDuration = !_isVisibleDuration;
                _isIconDuration = !_isIconDuration;
              });
            },
            icon: iconChange(_isIconDuration),
          ),
        ],
      ),
    );
  }

  Widget expiredDateWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: DateFormat("dd/MM/yyyy").format(widget.campaign.expirationDate),
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget durationWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: widget.campaign.duration.toString() + " days",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Icon iconChange(bool icon) {
    if (!icon) {
      return Icon(Icons.keyboard_arrow_left, size: 30);
    } else
      return Icon(Icons.keyboard_arrow_down, size: 30);
  }

  Widget joinButton(String jwt) {
    return AppButton(
      label: "Join Campaign",
      onPressed: () async {
        if (jwt == "") {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Error!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: AppText(
                  text: "You need to login first to perform this action",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff7C7C7C),
                ),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  ElevatedButton(
                      child: Text("OK"),
                      onPressed: () => Navigator.pop(context, 'OK'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: TextStyle(fontWeight: FontWeight.w600)))
                ],
              );
            },
          );
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var accountId = (prefs.getInt('accountId'));
          Account? account = await fetchAccountById(accountId!);
          if (account.store != null) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    widget.campaign.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: AppText(
                    text: "Are you sure want to join this campaign?",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C),
                  ),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          createContract(widget.campaign.id, account.store!.id);
                        },
                        child: Text("Join"),
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
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Error!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: AppText(
                    text: "You don't have permission to perfom this action!",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C),
                  ),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: <Widget>[
                    ElevatedButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.pop(context, 'OK'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.w600)))
                  ],
                );
              },
            );
          }
        }
      },
    );
  }
}

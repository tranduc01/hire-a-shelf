import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:intl/intl.dart';
import 'checkout_bottom_sheet.dart';

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
  bool _isVisibleType = false;
  bool _isIconType = false;

  final storage = new FlutterSecureStorage();

  int _id = 0;
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Open Sans'),
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    widget.campaign.content,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff7C7C7C),
                                        fontFamily: 'Open Sans'),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  widget.campaign.location,
                                  style: TextStyle(
                                    fontSize: 20,
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
                            getShelfTypeWidget(customWidget: shelfTypeWidget()),
                            getShelfType(),
                            Divider(thickness: 1),
                            getExpiredDate(customWidget: expiredDateWidget()),
                            Divider(thickness: 1),
                            getDurationWidget(customWidget: durationWidget()),
                            getDuration(),
                            SizedBox(
                              height: 10,
                            ),
                            joinButton(_jwt, _id),
                            Container(height: 20),
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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.campaign.products.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Visibility(
                  visible: _isVisible,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.network(
                      widget.campaign.products[index].imgURL,
                      height: 80,
                      width: 80,
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              Visibility(
                  visible: _isVisible,
                  child: Container(
                    padding: EdgeInsets.all(4.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color.fromARGB(141, 255, 235, 59),
                    ),
                    child: Text(
                      widget.campaign.products[index].price.toStringAsFixed(0) +
                          "vnđ",
                      style: TextStyle(fontFamily: 'Open Sans'),
                    ),
                  )),
              Spacer(),
              Visibility(
                  visible: _isVisible,
                  child: Expanded(
                      child: Text(
                    widget.campaign.products[index].name,
                    style: TextStyle(fontFamily: 'Open Sans'),
                  )))
            ],
          );
        });
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
              Spacer(),
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
              Spacer(),
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
        fontSize: 14,
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
        fontSize: 14,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget getShelfTypeWidget({Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          AppText(
              text: "Shelf Type", fontWeight: FontWeight.w600, fontSize: 16),
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
                _isVisibleType = !_isVisibleType;
                _isIconType = !_isIconType;
              });
            },
            icon: iconChange(_isIconType),
          ),
        ],
      ),
    );
  }

  Widget shelfTypeWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: widget.campaign.shelves.length.toString() + " types",
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget getShelfType() {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.campaign.shelves.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible: _isVisibleType,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          )),
                      child: ListTile(
                        title: Text(
                          widget.campaign.shelves[index].name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          widget.campaign.shelves[index].description,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Icon iconChange(bool icon) {
    if (!icon) {
      return Icon(Icons.keyboard_arrow_left, size: 30);
    } else
      return Icon(Icons.keyboard_arrow_down, size: 30);
  }

  Widget joinButton(String jwt, int id) {
    return AppButton(
      label: "Join Campaign",
      onPressed: () async {
        // Show the loading dialog

        // showDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (BuildContext context) {
        //     return LoadingDialog();
        //   },
        // );

        if (jwt == "") {
          // Hide the loading dialog
          // Navigator.pop(context);

          onClickDialog("You need to login first to perform this action");
        } else {
          Account? account = await fetchAccountById(id);
          if (account.store != null) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext alertContext) {
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
                          showBottomSheet(alertContext);
                        },
                        child: Text("Join"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.w600))),
                    ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(alertContext, 'Cancel'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            textStyle: TextStyle(fontWeight: FontWeight.w600)))
                  ],
                );
              },
            );
          } else {
            // Hide the loading dialog
            //Navigator.pop(context);

            onClickDialog("You don't have permission to perform this action!");
          }
        }
      },
    );
  }

  void onClickDialog(String text) {
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
            text: text,
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

  void showBottomSheet(context) {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(
            campaign: widget.campaign,
          );
        });
  }
}

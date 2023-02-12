import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  final GroceryItem groceryItem;
  final String? heroSuffix;

  const ProductDetailsScreen(this.groceryItem, {this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isIconDetail = false;
  bool _isIconDuration = false;
  bool _isVisible = false;
  bool _isVisibleDuration = false;

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
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.groceryItem.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: AppText(
                              text: widget.groceryItem.description,
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
                            "\$${widget.groceryItem.price}",
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
                      getProducts(coca),
                      Divider(thickness: 1),
                      getExpiredDate(customWidget: expiredDateWidget()),
                      Divider(thickness: 1),
                      getDurationWidget(customWidget: durationWidget()),
                      getDuration(),
                      SizedBox(
                        height: 10,
                      ),
                      AppButton(
                        label: "Join Campaign",
                      ),
                      Spacer(),
                      SizedBox(
                        height: 20,
                      )
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
            widget.groceryItem.name +
            "-" +
            (widget.heroSuffix ?? ""),
        child: Image(
          image: AssetImage(widget.groceryItem.imagePath),
        ),
      ),
    );
  }

  Widget getProducts(List<GroceryItem> items) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Row(
            children: [
              Visibility(
                  visible: _isVisible,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.asset(
                      item.imagePath,
                      height: 80,
                      width: 80,
                    ),
                  )),
              Spacer(),
              Visibility(visible: _isVisible, child: AppText(text: item.name)),
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
                          .format(widget.groceryItem.fromDate),
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
                          .format(widget.groceryItem.toDate),
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
        text: DateFormat("dd/MM/yyyy").format(widget.groceryItem.expiredDate),
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
        text: durationDay().toString() + " days",
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

  // double getTotalPrice() {
  //   return amount * widget.groceryItem.price;
  // }
  int durationDay() {
    Duration duration =
        widget.groceryItem.toDate.difference(widget.groceryItem.fromDate);
    return duration.inDays;
  }
}

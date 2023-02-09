import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/models/grocery_item.dart';

class ProductDetailsScreen extends StatefulWidget {
  final GroceryItem groceryItem;
  final String? heroSuffix;

  const ProductDetailsScreen(this.groceryItem, {this.heroSuffix});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isVisible = false;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 10000,
          child: Column(
            children: [
              getImageHeaderWidget(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView(
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
                      getProductDataRowWidget("Expired Date",
                          customWidget: nutritionWidget()),
                      Divider(thickness: 1),
                      getProductDataRowWidget(
                        "Duration",
                        customWidget: ratingWidget(),
                      ),
                      SizedBox(
                        height: 50,
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
                  child: Image.asset(
                    item.imagePath,
                    height: 100,
                    width: 100,
                  )),
              Spacer(),
              Visibility(visible: _isVisible, child: AppText(text: item.name))
            ],
          );
        });
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
                });
              },
              icon: Icon(Icons.arrow_back_ios)),
        ],
      ),
    );
  }

  Widget nutritionWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: widget.groceryItem.expiredDate,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  Widget ratingWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xffEBEBEB),
        borderRadius: BorderRadius.circular(5),
      ),
      child: AppText(
        text: "90 days",
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: Color(0xff7C7C7C),
      ),
    );
  }

  // double getTotalPrice() {
  //   return amount * widget.groceryItem.price;
  // }
}

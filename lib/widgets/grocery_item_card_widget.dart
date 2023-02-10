import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:intl/intl.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key? key, required this.item, this.heroSuffix})
      : super(key: key);
  final GroceryItem item;
  final String? heroSuffix;

  final double width = 174;
  final double height = 250;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "GroceryItem:" + item.name + "-" + (heroSuffix ?? ""),
                  child: imageWidget(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              text: item.name,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/out-of-time.svg",
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 8,
                ),
                AppText(
                  text: "Exp: " +
                      DateFormat("dd/MM/yyyy").format(item.expiredDate),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7C7C7C),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                SizedBox(
                  width: 4,
                ),
                SvgPicture.asset(
                  "assets/icons/location_icon.svg",
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: AppText(
                    text: item.location,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                AppText(
                  text: "\$${item.price.toStringAsFixed(2)}",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset(
        item.imagePath,
        fit: BoxFit.fill,
      ),
    );
  }

  // Widget addWidget() {
  //   return Container(
  //     height: 45,
  //     width: 45,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(17),
  //         color: AppColors.primaryColor),
  //     child: Center(
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.white,
  //         size: 25,
  //       ),
  //     ),
  //   );
  // }
}

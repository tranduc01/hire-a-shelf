import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:intl/intl.dart';

class GroceryItemCardWidget extends StatelessWidget {
  GroceryItemCardWidget({Key? key, required this.campaign, this.heroSuffix})
      : super(key: key);
  final Campaign campaign;
  final String? heroSuffix;

  final double width = 190;
  final double height = 260;
  final Color borderColor = Color.fromARGB(255, 187, 184, 184);
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
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "GroceryItem:" +
                      campaign.title +
                      "-" +
                      (heroSuffix ?? ""),
                  child: imageWidget(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              campaign.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans'),
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
                      DateFormat("dd/MM/yyyy").format(campaign.expirationDate),
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
                  width: 1.7,
                ),
                SvgPicture.asset(
                  "assets/icons/duration_icon.svg",
                  height: 23,
                  width: 23,
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: AppText(
                    text: campaign.duration.toString() + " days",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: AppText(
                    text: campaign.location,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.network(
        campaign.imgURL,
        fit: BoxFit.fill,
      ),
    );
  }
}

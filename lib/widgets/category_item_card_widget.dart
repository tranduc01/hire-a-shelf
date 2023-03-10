import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:intl/intl.dart';

class CategoryItemCardWidget extends StatelessWidget {
  CategoryItemCardWidget(
      {Key? key, required this.campaign, this.color = Colors.blue})
      : super(key: key);
  final Campaign campaign;

  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.7),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            child: imageWidget(),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Center(
                child: Column(
              children: [
                Text(
                  campaign.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans'),
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
                          DateFormat("dd/MM/yyyy")
                              .format(campaign.expirationDate),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C7C7C),
                    ),
                  ],
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
              ],
            )),
          )),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.network(
        campaign.imgURL,
        fit: BoxFit.contain,
      ),
    );
  }
}

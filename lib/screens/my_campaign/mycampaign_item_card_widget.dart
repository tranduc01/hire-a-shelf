import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:intl/intl.dart';

class MyCampaignItemCardWidget extends StatelessWidget {
  MyCampaignItemCardWidget(
      {Key? key, required this.campaign, this.color = Colors.blue})
      : super(key: key);
  final Campaign campaign;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 5, top: 5),
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
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
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
                            text: "Duration: " +
                                campaign.duration.toString() +
                                " days",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: Container(
                              padding: EdgeInsets.all(4.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(143, 0, 150, 135),
                              ),
                              child: Text(
                                "Participants: " +
                                    campaign.stores.length.toString(),
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.all(4.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: (campaign.status == "Pending")
                                ? Color.fromARGB(141, 231, 211, 24)
                                : (campaign.status == "Approved")
                                    ? Color.fromARGB(141, 83, 231, 24)
                                    : Color.fromARGB(141, 231, 90, 24),
                          ),
                          child: Text(
                            campaign.status,
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
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

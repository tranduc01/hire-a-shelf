import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/contract.dart';
import 'package:intl/intl.dart';

class MyCampaignStoreItemCardWidget extends StatelessWidget {
  MyCampaignStoreItemCardWidget(
      {Key? key, required this.contract, this.color = Colors.blue})
      : super(key: key);
  final Contract contract;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
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
                child: Column(
                  children: [
                    Text(
                      contract.campaign.title,
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
                          text: "Apply Date: " +
                              DateFormat("dd/MM/yyyy")
                                  .format(contract.createDate),
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
                                contract.campaign.duration.toString() +
                                " days",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7C7C7C),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.all(4.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: (contract.status == "Pending")
                                  ? Color.fromARGB(141, 231, 211, 24)
                                  : (contract.status == "Approved")
                                      ? Color.fromARGB(141, 83, 231, 24)
                                      : Color.fromARGB(141, 231, 90, 24),
                            ),
                            child: Text(
                              contract.status,
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
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
        contract.campaign.imgURL,
        fit: BoxFit.contain,
      ),
    );
  }
}

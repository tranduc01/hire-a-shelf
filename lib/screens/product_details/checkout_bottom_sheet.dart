import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/campaign.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/account.dart';
import 'join_success_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final Campaign campaign;
  CheckoutBottomSheet({required this.campaign, Key? key}) : super(key: key);
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  final storage = new FlutterSecureStorage();
  Future<String?> readFromStorage(String key) async {
    return await storage.read(key: key);
  }

  createContract(int campaignId, int storeId) async {
    var response = await http.post(
// Uri.parse("http://10.0.2.2:8080/api/contract"),
      Uri.parse("https://hireashelf.up.railway.app/api/contract"),
      body: jsonEncode({"campaignId": campaignId, "storeId": storeId}),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode == 200) {
      onPlaceOrderClicked();
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: new Wrap(
        children: <Widget>[
          Row(
            children: [
              AppText(
                text: "Checkout",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ))
            ],
          ),
          SizedBox(
            height: 45,
          ),
          getDivider(),
          checkoutRow("Name", trailingText: widget.campaign.title),
          getDivider(),
          checkoutRow("Duration",
              trailingText: widget.campaign.duration.toString() + " days"),
          getDivider(),
          checkoutRow("Brand", trailingText: widget.campaign.brand.name),
          getDivider(),
          checkoutRow("Contact Number",
              trailingText: widget.campaign.brand.phone),
          getDivider(),
          SizedBox(
            height: 30,
          ),
          termsAndConditionsAgreement(context),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: AppButton(
              label: "Join Campaign",
              // fontWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(
                vertical: 25,
              ),
              onPressed: () async {
                var accountId = await readFromStorage("accountId");
                int id = 0;
                if (accountId != null) {
                  id = int.parse(accountId);
                } else {
                  id = 0;
                }
                Account? account = await fetchAccountById(id);
                createContract(widget.campaign.id, account.store!.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By joining this campaign you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: " Terms",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " And"),
            TextSpan(
              text: " Conditions",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingText == null
              ? (trailingWidget ?? Container())
              : Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: AppText(
                        text: trailingText,
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ))),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return JoinSuccessDialouge();
        });
  }
}

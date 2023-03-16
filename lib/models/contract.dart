import 'package:grocery_app/models/campaign.dart';
import 'package:grocery_app/models/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contract {
  final Campaign campaign;
  final Store store;
  final DateTime createDate;
  final DateTime? approvalDate;
  final String status;

  Contract({
    required this.campaign,
    required this.store,
    required this.createDate,
    this.approvalDate,
    required this.status,
  });
  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
        campaign: Campaign.fromJson(json['campaignResponse']),
        store: Store.fromJson(json['storeResponse']),
        createDate: DateTime.parse(json['createDate']),
        approvalDate: json['approvalDate'] == null
            ? null
            : DateTime.parse(json['approvalDate']),
        status: json['status']);
  }
}

Future<List<Contract>> fetchContracts() async {
  var response = await http
      .get(Uri.parse("https://hireashelf.up.railway.app/api/contract"));
  //.get(Uri.parse("http://10.0.2.2:8080/api/contract"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => Contract.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

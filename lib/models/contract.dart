import 'package:grocery_app/models/campaign.dart';
import 'package:grocery_app/models/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contract {
  final Campaign campaign;
  final Store store;
  Contract({required this.campaign, required this.store});
  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
        campaign: Campaign.fromJson(json['campaignResponse']),
        store: Store.fromJson(json['storeResponse']));
  }
}

Future<List<Contract>> fetchContracts() async {
  var response = await http
      //.get(Uri.parse("https://hireashelf.up.railway.app/api/contract"));
      .get(Uri.parse("http://10.0.2.2:8080/api/contract"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => Contract.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

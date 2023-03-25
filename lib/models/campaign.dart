import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/models/brand.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/shelf.dart';
import 'package:grocery_app/models/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constraints/constraints.dart';

class Campaign {
  final int id;
  final String title;
  final String content;
  final DateTime expirationDate;
  final DateTime createDate;
  final DateTime startDate;
  final int duration;
  final String imgURL;
  final String status;
  final Brand brand;
  final String location;
  final List<Store> stores;
  final List<Shelf> shelves;
  final List<Product> products;

  Campaign(
      {required this.id,
      required this.title,
      required this.content,
      required this.expirationDate,
      required this.createDate,
      required this.startDate,
      required this.duration,
      required this.imgURL,
      required this.brand,
      required this.status,
      required this.stores,
      required this.shelves,
      required this.products,
      required this.location});
  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        expirationDate: DateTime.parse(json['expirationDate']),
        createDate: DateTime.parse(json['createdDate']),
        startDate: DateTime.parse(json['startDate']),
        duration: json['duration'],
        imgURL: json['imgURL'],
        status: json['status'],
        brand: Brand.fromJson(json['brand']),
        location: json['city'],
        stores:
            (json['appliers'] as List).map((e) => Store.fromJson(e)).toList(),
        products: (json['productResponseSet'] as List)
            .map((e) => Product.fromJson(e))
            .toList(),
        shelves: (json['shelvesTypeResponses'] as List)
            .map((e) => Shelf.fromJson(e))
            .toList());
  }
}

Future<List<Campaign>> fetchCampaigns() async {
  var response =
      await http.get(Uri.parse("$BASE_URL/campaign?states=Approved"));
  if (response.statusCode == 200) {
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return (responseJson['listResponse'] as List)
        .map((e) => Campaign.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

Future<List<Campaign>> fetchCampaignsByBrand(int id, int page) async {
  final storage = new FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final headers = {
    'Authorization': 'Bearer ' + token!,
    'Content-Type': 'application/json',
  };
  var response = await http.get(
      Uri.parse(
          "$BASE_URL/campaign?brandId=$id&page=$page&states=Approved&states=Pending&states=Declined&states=Disable"),
      headers: headers);
  if (response.statusCode == 200) {
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return (responseJson['listResponse'] as List)
        .map((e) => Campaign.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

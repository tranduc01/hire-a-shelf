import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grocery_app/models/admin.dart';
import 'package:grocery_app/models/brand.dart';
import 'package:grocery_app/models/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constraints/constraints.dart';

class Account {
  int id;
  String username;
  bool status;
  String email;
  Brand? brand;
  Store? store;
  Admin? admin;
  Account(
      {required this.id,
      required this.username,
      required this.status,
      required this.email,
      this.brand,
      this.store,
      this.admin});
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['id'],
        username: json['username'],
        status: json['status'],
        email: json['email'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        store: json['store'] == null ? null : Store.fromJson(json['store']),
        admin: json['admin'] == null ? null : Admin.fromJson(json['admin']));
  }
}

Future<Account> fetchAccountById(int id) async {
  final storage = new FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  final headers = {
    'Authorization': 'Bearer ' + token!,
    'Content-Type': 'application/json',
  };
  var response =
      await http.get(Uri.parse("$BASE_URL/account/$id"), headers: headers);
  if (response.statusCode == 200) {
    return Account.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception("Fail to fetch");
  }
}

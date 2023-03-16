import 'package:grocery_app/models/admin.dart';
import 'package:grocery_app/models/brand.dart';
import 'package:grocery_app/models/store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var response =
      //await http.get(Uri.parse("http://10.0.2.2:8080/api/account/$id"));
      await http
          .get(Uri.parse("https://hireashelf.up.railway.app/api/account/$id"));
  if (response.statusCode == 200) {
    return Account.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception("Fail to fetch");
  }
}

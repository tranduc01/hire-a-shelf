import 'package:grocery_app/models/brand.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Campaign {
  final int id;
  final String title;
  final String content;
  final DateTime expirationDate;
  final DateTime createDate;
  final DateTime startDate;
  final int duration;
  final String imgURL;
  final Brand brand;

  Campaign(
      {required this.id,
      required this.title,
      required this.content,
      required this.expirationDate,
      required this.createDate,
      required this.startDate,
      required this.duration,
      required this.imgURL,
      required this.brand});
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
        brand: Brand.fromJson(json['brand']));
  }
}

Future<List<Campaign>> fetchCampaigns() async {
  var response = await http.get(Uri.parse(
      "https://hireashelf.up.railway.app/api/campaign?page=0&states=Approved"));
  //.get(Uri.parse("http://10.0.2.2:8080/api/campaign"));
  if (response.statusCode == 200) {
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return (responseJson['listResponse'] as List)
        .map((e) => Campaign.fromJson(e))
        .toList();
    // return (json.decode(response.body) as List)
    //     .map((e) => Campaign.fromJson(e))
    //     .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

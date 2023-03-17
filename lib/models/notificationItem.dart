import 'dart:convert';
import 'package:grocery_app/constraints/constraints.dart';
import 'package:http/http.dart' as http;

class NotificationItem {
  final String title;
  final String body;
  final String type;

  NotificationItem(
      {required this.title, required this.body, required this.type});
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
        title: json['title'], body: json['body'], type: json['type']);
  }
}

Future<List<NotificationItem>> fetchNotificationByAccountId(int id) async {
  var response = await http.get(Uri.parse("$BASE_URL/notification/$id"));
  if (response.statusCode == 200) {
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => NotificationItem.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationItem {
  final String title;
  final String body;

  NotificationItem({required this.title, required this.body});
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<List<NotificationItem>> fetchNotificationByAccountId(int id) async {
  var response =
      //await http.get(Uri.parse("http://10.0.2.2:9090/api/notification/$id"));
      await http.get(
          Uri.parse("https://hireashelf.up.railway.app/api/notification/$id"));
  if (response.statusCode == 200) {
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => NotificationItem.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

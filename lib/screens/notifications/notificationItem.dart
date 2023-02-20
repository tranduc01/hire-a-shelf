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

List<NotificationItem> notiItem = [
  NotificationItem(title: "Notification 1", body: "Detail 1"),
  NotificationItem(title: "Notification 2", body: "Detail 2"),
  NotificationItem(title: "Notification 3", body: "Detail 3"),
];

Future<List<NotificationItem>> fetchNotificationByAccountId(int id) async {
  var response =
      await http.get(Uri.parse("http://10.0.2.2:9090/api/notification/$id"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => NotificationItem.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}

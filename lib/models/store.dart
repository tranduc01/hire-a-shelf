import 'package:grocery_app/models/location.dart';

class Store {
  int id;
  String name;
  String phone;
  String? description;
  String? logo;
  DateTime participateDate;
  Location location;
  Store(
      {required this.id,
      required this.name,
      required this.phone,
      required this.description,
      required this.participateDate,
      required this.location,
      this.logo});
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        description: json['description'],
        participateDate: DateTime.parse(json['participateDate']),
        location: Location.fromJson(json['location']),
        logo: json['logo']);
  }
}

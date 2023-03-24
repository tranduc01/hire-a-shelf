import 'package:grocery_app/models/location.dart';

class Brand {
  int id;
  String name;
  String phone;
  String? description;
  String? logo;
  DateTime participateDate;
  Location location;
  Brand(
      {required this.id,
      required this.name,
      required this.phone,
      required this.description,
      required this.participateDate,
      required this.location,
      this.logo});
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        description: json['description'],
        participateDate: DateTime.parse(json['participateDate']),
        location: Location.fromJson(json['location']),
        logo: json['logo']);
  }
}

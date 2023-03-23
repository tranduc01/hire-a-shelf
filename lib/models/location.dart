class Location {
  int id;
  String district;
  String ward;
  String address;
  String city;
  Location(
      {required this.id,
      required this.address,
      required this.city,
      required this.district,
      required this.ward});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        address: json['address'],
        city: json['city'],
        district: json['district'],
        ward: json['ward']);
  }
}

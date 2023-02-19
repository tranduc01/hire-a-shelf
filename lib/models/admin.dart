class Admin {
  int id;
  String address;
  String phone;

  Admin({
    required this.id,
    required this.address,
    required this.phone,
  });
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        id: json['id'], address: json['address'], phone: json['phone']);
  }
}

class Brand {
  int id;
  String name;
  String phone;
  String description;
  String? logo;
  Brand(
      {required this.id,
      required this.name,
      required this.phone,
      required this.description,
      this.logo});
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        description: json['description'],
        logo: json['logo']);
  }
}

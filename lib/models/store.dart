class Store {
  int id;
  String name;
  String phone;
  String description;
  String? logo;
  Store(
      {required this.id,
      required this.name,
      required this.phone,
      required this.description,
      this.logo});
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        description: json['description'],
        logo: json['logo']);
  }
}

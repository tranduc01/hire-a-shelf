class Store {
  int id;
  String name;
  String phone;
  String description;
  Store(
      {required this.id,
      required this.name,
      required this.phone,
      required this.description});
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        description: json['description']);
  }
}

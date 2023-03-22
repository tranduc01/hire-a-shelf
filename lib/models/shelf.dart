class Shelf {
  int id;
  String name;
  String description;
  bool status;
  Shelf(
      {required this.id,
      required this.name,
      required this.description,
      required this.status});

  factory Shelf.fromJson(Map<String, dynamic> json) {
    return Shelf(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        status: json['status']);
  }
}

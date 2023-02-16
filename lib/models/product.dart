class Product {
  final int id;
  final String name;
  final String imgURL;
  Product({required this.id, required this.name, required this.imgURL});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name'], imgURL: json['imgURL']);
  }
}

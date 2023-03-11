class Product {
  final int id;
  final String name;
  final double price;
  final String imgURL;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imgURL});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        imgURL: json['imgURL']);
  }
}

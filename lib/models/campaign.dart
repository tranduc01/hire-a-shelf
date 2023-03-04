import 'package:grocery_app/models/brand.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Campaign {
  final int id;
  final String title;
  final String content;
  final DateTime expirationDate;
  final DateTime createDate;
  final DateTime startDate;
  final int duration;
  final String imgURL;
  final Brand brand;

  Campaign(
      {required this.id,
      required this.title,
      required this.content,
      required this.expirationDate,
      required this.createDate,
      required this.startDate,
      required this.duration,
      required this.imgURL,
      required this.brand});
  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        expirationDate: DateTime.parse(json['expirationDate']),
        createDate: DateTime.parse(json['createdDate']),
        startDate: DateTime.parse(json['startDate']),
        duration: json['duration'],
        imgURL: json['imgURL'],
        brand: Brand.fromJson(json['brand']));
  }
}

Future<List<Campaign>> fetchCampaigns() async {
  var response = await http
      //.get(Uri.parse("https://hireashelf.up.railway.app/api/campaign"));
      .get(Uri.parse("http://10.0.2.2:9090/api/campaign"));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((e) => Campaign.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}


// var demoItems = [
//   GroceryItem(
//       id: 1,
//       name: "Coca-cola Spring Campaign",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/cocacola.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 2,
//       name: "Pepsi Additional Campaign",
//       expiredDate: DateTime.parse("2023-02-21"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/pepsi.jpg",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-12'),
//       toDate: DateTime.parse('2023-03-15')),
//   GroceryItem(
//       id: 3,
//       name: "Red Bull Sales Expansion",
//       expiredDate: DateTime.parse("2023-03-15"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/redbull.jpg",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-09'),
//       toDate: DateTime.parse('2023-02-22')),
//   GroceryItem(
//       id: 4,
//       name: "Vinamilk Sales Campaign",
//       expiredDate: DateTime.parse("2023-03-22"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/vinamilk.jpg",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 5,
//       name: "KFC Sales Campaign",
//       expiredDate: DateTime.parse("2023-03-18"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/kfc.jpg",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 6,
//       name: "Dutch Lay Sales Campaign",
//       expiredDate: DateTime.parse("2023-02-04"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
//       price: 4.99,
//       imagePath: "assets/images/grocery_images/dutchlady.jpg",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-02-01'),
//       toDate: DateTime.parse('2023-03-31')),
// ];

// var exclusiveOffers = [demoItems[0], demoItems[1], demoItems[4]];

// var bestSelling = [demoItems[2], demoItems[3], demoItems[5]];

// var coca = [beverages[0], beverages[4], beverages[2]];

// var beverages = [
//   GroceryItem(
//       id: 7,
//       name: "Dite Coke",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 1.99,
//       imagePath: "assets/images/beverages_images/diet_coke.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 8,
//       name: "Sprite Can",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 1.50,
//       imagePath: "assets/images/beverages_images/sprite.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 8,
//       name: "Apple Juice",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 15.99,
//       imagePath: "assets/images/beverages_images/apple_and_grape_juice.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 9,
//       name: "Orange Juice",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 1.50,
//       imagePath: "assets/images/beverages_images/orange_juice.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 10,
//       name: "Coca Cola Can",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 4.99,
//       imagePath: "assets/images/beverages_images/coca_cola.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
//   GroceryItem(
//       id: 11,
//       name: "Pepsi Can",
//       expiredDate: DateTime.parse("2023-03-31"),
//       description:
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
//       price: 4.99,
//       imagePath: "assets/images/beverages_images/pepsi.png",
//       location: "Q9, HCM, VN",
//       fromDate: DateTime.parse('2023-01-01'),
//       toDate: DateTime.parse('2023-03-31')),
// ];

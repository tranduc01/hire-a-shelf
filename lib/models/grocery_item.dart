class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String location;

  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.location,
  });
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Coca-cola Spring Campaign",
      description: "31/03/2023",
      price: 4.99,
      imagePath: "assets/images/grocery_images/cocacola.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 2,
      name: "Pepsi Additional Campaign",
      description: "28/02/2023",
      price: 4.99,
      imagePath: "assets/images/grocery_images/pepsi.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 3,
      name: "Red Bull Sales Expansion",
      description: "22/03/2022",
      price: 4.99,
      imagePath: "assets/images/grocery_images/redbull.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 4,
      name: "Vinamilk Sales Campaign",
      description: "12/03/2022",
      price: 4.99,
      imagePath: "assets/images/grocery_images/vinamilk.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 5,
      name: "KFC Sales Campaign",
      description: "21/02/2023",
      price: 4.99,
      imagePath: "assets/images/grocery_images/kfc.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 6,
      name: "Dutch Lay Sales Campaign",
      description: "11/03/2023",
      price: 4.99,
      imagePath: "assets/images/grocery_images/dutchlady.jpg",
      location: "Q9, HCM, VN"),
];

var exclusiveOffers = [demoItems[0], demoItems[1], demoItems[4]];

var bestSelling = [demoItems[2], demoItems[3], demoItems[5]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Dite Coke",
      description: "355ml, Price",
      price: 1.99,
      imagePath: "assets/images/beverages_images/diet_coke.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 8,
      name: "Sprite Can",
      description: "325ml, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/sprite.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 8,
      name: "Apple Juice",
      description: "2L, Price",
      price: 15.99,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 9,
      name: "Orange Juice",
      description: "2L, Price",
      price: 1.50,
      imagePath: "assets/images/beverages_images/orange_juice.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 10,
      name: "Coca Cola Can",
      description: "325ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/coca_cola.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 11,
      name: "Pepsi Can",
      description: "330ml, Price",
      price: 4.99,
      imagePath: "assets/images/beverages_images/pepsi.png",
      location: "Q9, HCM, VN"),
];

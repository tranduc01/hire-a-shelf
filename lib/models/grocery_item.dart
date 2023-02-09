class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final String expiredDate;
  final double price;
  final String imagePath;
  final String location;

  GroceryItem(
      {this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imagePath,
      required this.location,
      required this.expiredDate});
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Coca-cola Spring Campaign",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/cocacola.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 2,
      name: "Pepsi Additional Campaign",
      expiredDate: "21/02/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/pepsi.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 3,
      name: "Red Bull Sales Expansion",
      expiredDate: "15/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/redbull.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 4,
      name: "Vinamilk Sales Campaign",
      expiredDate: "22/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/vinamilk.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 5,
      name: "KFC Sales Campaign",
      expiredDate: "18/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/kfc.jpg",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 6,
      name: "Dutch Lay Sales Campaign",
      expiredDate: "02/04/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex.",
      price: 4.99,
      imagePath: "assets/images/grocery_images/dutchlady.jpg",
      location: "Q9, HCM, VN"),
];

var exclusiveOffers = [demoItems[0], demoItems[1], demoItems[4]];

var bestSelling = [demoItems[2], demoItems[3], demoItems[5]];

var coca = [beverages[0], beverages[4], beverages[2]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Dite Coke",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 1.99,
      imagePath: "assets/images/beverages_images/diet_coke.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 8,
      name: "Sprite Can",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 1.50,
      imagePath: "assets/images/beverages_images/sprite.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 8,
      name: "Apple Juice",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 15.99,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 9,
      name: "Orange Juice",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 1.50,
      imagePath: "assets/images/beverages_images/orange_juice.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 10,
      name: "Coca Cola Can",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 4.99,
      imagePath: "assets/images/beverages_images/coca_cola.png",
      location: "Q9, HCM, VN"),
  GroceryItem(
      id: 11,
      name: "Pepsi Can",
      expiredDate: "31/03/2023",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo felis vitae elit luctus faucibus sed sed eros. Nam ante nisl, volutpat eget mauris vitae, accumsan iaculis ex. Sed eu leo auctor, tincidunt purus posuere, efficitur eros.",
      price: 4.99,
      imagePath: "assets/images/beverages_images/pepsi.png",
      location: "Q9, HCM, VN"),
];

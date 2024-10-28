import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String? id;
  String? type;
  String? name;
  String? section;
  String? description;
  bool? isFavorited;
  String? image;
  int? price;
  int? number;
  String? color;

  Medicine(
      {this.id,
      required this.type,
      required this.section,
      required this.price,
      required this.color,
      required this.image,
      required this.name,
      required this.description,
      required this.number,
      required this.isFavorited});

  Medicine.fromMap(DocumentSnapshot data) {
    id = data.id;
    type = data["type"];
    price = data["price"];
    name = data["name"];
    image = data["image"];
    color = data["color"];
    number = data["number"];
    section = data["section"];
    description = data["description"];
    isFavorited = data["is_favorited"];
  }
  Medicine.fromJson(Map<String, dynamic> data) {
    // id = data.id;
    type = data["sizes"];
    // Update to handle price parsing
    String priceString = data["price"].toString();
    // Remove any non-numeric characters (like ".") before parsing
    price = int.parse(priceString.replaceAll(RegExp(r'[^0-9]'), ''));
    name = data["name"];
    image = data["image"];
    color = data["color"];
    number = data["number"];
    section = data["section"];
    description = data["description"];
    isFavorited = data["is_favorited"];
  }
}

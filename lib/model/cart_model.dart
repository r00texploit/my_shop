import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? id;
  String? type;
  String? name;
  String? description;
  String? image;
  int? price;
  int? number;
  // String? size;
  String? color;
  int count = 0;

  Cart(
      {this.id,
      required this.count,
      // required this.size,
      required this.type,
      required this.price,
      required this.color,
      required this.image,
      required this.name,
      required this.description,
      required this.number});

  Cart.fromMap(DocumentSnapshot data) {
    id = data.id;
    type = data["type"];
    price = data["price"];
    name = data["name"];
    image = data["image"];
    color = data["color"];
    // size = data["size"];
    number = data["number"];
    description = data["description"];
  }
}

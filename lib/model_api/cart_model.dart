// To parse this JSON data, do
//
//     final cartFood = cartFoodFromJson(jsonString);

import 'dart:convert';

List<CartFood> cartFoodFromJson(String str) => List<CartFood>.from(json.decode(str).map((x) => CartFood.fromJson(x)));

String cartFoodToJson(List<CartFood> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CartItem{
  static List<CartFood> cart = [];

  CartFood getById(int id) =>
      cart.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  CartFood getByPosition(int pos) => cart[pos];
}
class CartFood {
  CartFood({
    required this.idCart,
    required this.qty,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  int idCart;
  int qty;
  int id;
  String name;
  int price;
  String image;

  factory CartFood.fromJson(Map<String, dynamic> json) => CartFood(
    idCart: json["idCart"],
    qty: json["qty"],
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "idCart": idCart,
    "qty": qty,
    "id": id,
    "name": name,
    "price": price,
    "image": image,
  };
}

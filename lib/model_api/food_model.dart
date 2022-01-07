import 'dart:convert';

List<FoodModel> foodModelFromJson(String str) => List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodItem{

  static List<FoodModel> foody = [];

  FoodModel getById(int id) =>
      foody.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  FoodModel getByPosition(int pos) => foody[pos];
}
class FoodModel {
  FoodModel({
    required this.id,
    required this.name,
    required this.star,
    required this.price,
    required this.desc,
    required this.image,
    required this.country,
    required this.person,
    required this.qty,
  });

  int id;
  String name;
  int star;
  int price;
  String desc;
  String image;
  String country;
  int person;
  int qty;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    id: json["id"],
    name: json["name"],
    star: json["star"],
    price: json["price"],
    desc: json["desc"],
    image: json["image"],
    country: json["country"],
    person: json["person"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "star": star,
    "price": price,
    "desc": desc,
    "image": image,
    "country": country,
    "person": person,
    "qty": qty,
  };
}

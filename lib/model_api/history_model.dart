// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  HistoryModel({
    required this.id,
    required this.price,
    required this.payment,
    required this.date,
    required this.user,
    required this.idPayment,
  });

  int id;
  int price;
  String payment;
  DateTime date;
  String user;
  String idPayment;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json["id"],
    price: json["price"],
    payment: json["payment"],
    date: DateTime.parse(json["date"]),
    user: json["user"],
    idPayment: json["idPayment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "payment": payment,
    "date": date.toIso8601String(),
    "user": user,
    "idPayment": idPayment,
  };
}

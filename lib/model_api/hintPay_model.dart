// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel({
    required this.namaVa,
    required this.nomor,
  });

  String namaVa;
  String nomor;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    namaVa: json["nama_va"],
    nomor: json["nomor"],
  );

  Map<String, dynamic> toJson() => {
    "nama_va": namaVa,
    "nomor": nomor,
  };
}

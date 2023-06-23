// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'dart:convert';

class ProductModel {
  final String? brand;
  final String? name;
  final int? price, discount;

  ProductModel({
    this.discount,
    this.brand,
    this.name,
    this.price,
  });

  ProductModel copyWith({String? brand, String? name, int? price, int? discount}) => ProductModel(
      brand: brand ?? this.brand,
      name: name ?? this.name,
      price: price ?? this.price,
      discount: discount ?? this.discount);

  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        brand: json["brand"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "name": name,
        "price": price,
      };
}

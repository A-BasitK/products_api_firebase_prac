// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.name,
    required this.price,
    required this.imageLink,
    required this.description,
    required this.qunatity,
  });

  num qunatity;
  String name;
  String price;
  String imageLink;
  String description;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    qunatity: 1,
    name: json["name"],
    price: json["price"],
    imageLink: json["image_link"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": imageLink,
    "description": description,
    "quantity": qunatity,
  };
}

enum Brand { MAYBELLINE }

final brandValues = EnumValues({
  "maybelline": Brand.MAYBELLINE
});

class ProductColor {
  ProductColor({
    required this.hexValue,
    required this.colourName,
  });

  String? hexValue;
  String? colourName;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
    hexValue: json["hex_value"],
    colourName: null,
  );

  Map<String, dynamic> toJson() => {
    "hex_value": hexValue,
    "colour_name": null,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap=Map();

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

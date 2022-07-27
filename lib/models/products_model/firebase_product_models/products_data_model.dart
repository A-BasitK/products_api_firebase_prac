// To parse this JSON data, do
//
//     final productsDataModel = productsDataModelFromJson(jsonString);

import 'dart:convert';

ProductsDataModel productsDataModelFromJson(String str) => ProductsDataModel.fromJson(json.decode(str));

String productsDataModelToJson(ProductsDataModel data) => json.encode(data.toJson());

class ProductsDataModel {
  ProductsDataModel({
    required this.productName,
    required this.price,
    required this.quantity,
  });

  String productName;
  String price;
  num quantity;

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) => ProductsDataModel(
    productName: json["Product Name"],
    price: json["Price"],
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "Product Name": productName,
    "Price": price,
    "Quantity": quantity,
  };
}

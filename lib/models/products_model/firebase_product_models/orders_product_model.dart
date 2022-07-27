// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);
import 'dart:convert';

import 'package:products_api_firebase_prac/models/products_model/firebase_product_models/products_data_model.dart';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());
class Order
{
  OrdersModel ordersModel;
  List<ProductsDataModel> productsDataModel;
  Order({required this.productsDataModel,required this.ordersModel});
}
class OrdersModel {
  OrdersModel({
    required this.totalPrice,
    required this.discount,
    required this.netTotal,
  });

  num totalPrice;
 num discount;
num netTotal;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    totalPrice: json["Total Price"],
    discount: json["Discount"],
    netTotal: json["Net total"],
  );

  Map<String, dynamic> toJson() => {
    "Total Price": totalPrice,
    "Discount": discount,
    "Net total": netTotal,
  };
}

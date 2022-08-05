// To parse this JSON data, do
//
//     final orderModel = orderModelFromMap(jsonString);
import 'dart:convert';

OrderModel orderModelFromMap(String str) => OrderModel.fromMap(json.decode(str));

String orderModelToMap(OrderModel data) => json.encode(data.toMap());

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.data,
  });

  String orderId;
  Data data;

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "orderId": orderId,
    "data": data.toMap(),
  };
}

class Data {
  Data({
    required this.discount,
    required this.nettotal,
    required this.totalPrice,
    required this.status,
    required this.products,
  });

  int discount;
  double nettotal;
  double totalPrice;
  String status;
  List<Product> products;


  factory Data.fromMap(Map<String, dynamic> json) => Data(
    discount: json["Discount"],
    nettotal: json["Nettotal"].toDouble(),
    totalPrice: json["TotalPrice"].toDouble(),
    status: json["status"],
    products: List<Product>.from(json["Products"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Discount": discount,
    "Nettotal": nettotal,
    "TotalPrice": totalPrice,
    "status": status,
    "Products": List<dynamic>.from(products.map((x) => x.toMap())),
  };
}

class Product {
  Product({
    required this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.qunatity
  });

  String description;
  String image;
  String name;
  String price;
  num qunatity;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    description: json["description"],
    image: json["image_link"],
    name: json["name"],
    qunatity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "description": description,
    "image": image,
    "name": name,
    "price": price,
    'quantity':qunatity
  };
}
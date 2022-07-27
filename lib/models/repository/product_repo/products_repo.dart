import 'package:http/http.dart'as http;
import 'package:products_api_firebase_prac/models/products_model/products_model.dart';

 class ProductRepo{
   static Future<List<ProductModel>?> getProductData() async{
     const baseUrl="http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";
     final response= await http.get(Uri.parse(baseUrl));
     if (response.statusCode == 200){
       return productModelFromJson(response.body);
     }
     return null;
   }

}
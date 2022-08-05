import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:products_api_firebase_prac/models/products_model/products_model.dart';
import '../../../models/products_model/firebase_product_models/orders_product_model.dart';
import '../../../models/products_model/firebase_product_models/products_data_model.dart';
part 'fetch_invoice_firestore_state.dart';

class FetchInvoiceFirestoreCubit extends Cubit<FetchInvoiceFirestoreState> {

  FetchInvoiceFirestoreCubit() : super(FetchInvoiceFirestoreInitial()){
    fetchInvoiceData();
  }
  fetchInvoiceData()async{
    emit(FetchInvoiceFirestoreLoading());
    try{
      List<OrderModel> orders=[];
      var ref=FirebaseFirestore.instance.collection("orders").snapshots();
      ref.listen((event) async{
        orders.clear();
        for(var d in event.docs){
          String id= d.id;
          print(jsonEncode(d.data()));
          Data data=Data.fromMap(d.data());
          OrderModel model=OrderModel(orderId: id, data: data);
          orders.add(model);
        }
        emit(FetchInvoiceFirestoreLoaded(allorders: orders));
      },);
    }catch(e){}


  }
  updateStatus({required String status, required String productId}){

    FirebaseFirestore.instance.collection("orders").doc(productId).update({
      "status": status
    });
  }

}
// List<ProductsDataModel> products=[];
//         orders.add(Order(productsDataModel: products, ordersModel: ordersModel));
// var reff= await FirebaseFirestore.instance.collection("orders").doc(id).collection("Products").get();
// for(var e in reff.docs){
//   String id=e.id;
//   print(e.data());
//   ProductsDataModel productsDataModel=ProductsDataModel.fromJson(e.data());
//   products.add(productsDataModel);
//
// }

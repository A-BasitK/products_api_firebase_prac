import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:products_api_firebase_prac/models/products_model/firebase_product_models/orders_product_model.dart';

part 'update_invoice_firestore_state.dart';

class UpdateInvoiceFirestoreCubit extends Cubit<UpdateInvoiceFirestoreState> {
  UpdateInvoiceFirestoreCubit() : super(UpdateInvoiceFirestoreInitial());

  listenInvoice(String productId){
    var ref=FirebaseFirestore.instance.collection("orders").doc(productId).snapshots();
    ref.listen((d) {
      d.data();
      OrderModel orderModel= OrderModel(orderId: productId, data: Data.fromMap(d.data()!));
      emit(UpdateInvoiceFirestoreUpdated(orderDetails: orderModel));
    });

  }
  updateInvoice(OrderModel orderModel)async{
    var productToMap=List<Map>.from(orderModel.data.products.map((e) => e.toMap()));
    await FirebaseFirestore.instance.collection("orders").doc(orderModel.orderId).update({
      'Products':productToMap,
      'Nettotal':orderModel.data.nettotal,
      'TotalPrice':orderModel.data.totalPrice
    });


  }

}

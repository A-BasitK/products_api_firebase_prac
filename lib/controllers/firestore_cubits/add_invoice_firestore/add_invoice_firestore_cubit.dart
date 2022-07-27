import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

import '../../../models/products_model/products_model.dart';

part 'add_invoice_firestore_state.dart';

class AddInvoiceFirestoreCubit extends Cubit<AddInvoiceFirestoreState> {
  AddInvoiceFirestoreCubit() : super(AddInvoiceFirestoreInitial());
  addInvoiceData(List<ProductModel> productsAllData, var totalPrice,
      var discount, var netTotal) async {
    emit(AddInvoiceLoading());
    var id = FirebaseFirestore.instance.collection("orders").doc().id;
    await FirebaseFirestore.instance.collection("orders").doc(id).set({
      "Total Price": totalPrice,
      "Discount": discount,
      "Net total": netTotal,
    });
    for (var add in productsAllData) {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(id)
          .collection("Products")
          .add({
        "Product Name": add.name,
        "Price": add.price,
        "Quantity": add.qunatity,
      });
    }
    print("data Loaded");
    emit(AddInvoiceLoaded());
  }
}

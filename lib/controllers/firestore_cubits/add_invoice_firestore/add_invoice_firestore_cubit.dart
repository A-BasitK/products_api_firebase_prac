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
    try {
      var map = List<Map>.from(productsAllData.map((e) => e.toJson()));
      await FirebaseFirestore.instance.collection("orders").add({
        "TotalPrice": totalPrice,
        "Discount": discount,
        "Nettotal": netTotal,
        "status": "pending",
        "Products": map,
      });
      print("data Loaded");
      emit(AddInvoiceLoaded());
    } catch (e) {
      emit(AddInvoiceError(err: e));
    }

    // for (var add in productsAllData) {
    //   await FirebaseFirestore.instance
    //       .collection("orders")
    //       .doc(id)
    //       .collection("Products")
    //       .add({
    //     "Product Name": add.name,
    //     "Price": add.price,
    //     "Quantity": add.qunatity,
    //   });
    // }
  }
}

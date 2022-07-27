import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/fetch_invoice_firestore/fetch_invoice_firestore_cubit.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("CheckOut"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BlocBuilder<FetchInvoiceFirestoreCubit,
            FetchInvoiceFirestoreState>(
          builder: (context, state) {
            if (state is FetchInvoiceFirestoreLoading) {
              print("Loading");
            }
            if (state is FetchInvoiceFirestoreLoaded) {
              return ListView.builder(
                  itemCount: state.allorders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          borderRadius:
                              BorderRadius.all(Radius.circular(13))),
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "Products Quantity: ${state.allorders[index].productsDataModel.length}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Total Price: \$${state.allorders[index].ordersModel.totalPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))))
                            ],
                          )),
                          const SizedBox(
                            height: 9,
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Discount: ${state.allorders[index].ordersModel.discount}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Net Total: \$${state.allorders[index].ordersModel.netTotal}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))))
                            ],
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 25,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Pending",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ))
                              ],
                            ),
                          )),
                        ],
                      ),
                    );
                  });
            }
            return Container(
              height: 0,
              width: 0,
            );
          },
        ),
      ),
    );
  }
}

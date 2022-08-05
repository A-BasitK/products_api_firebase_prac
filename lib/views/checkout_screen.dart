import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/fetch_invoice_firestore/fetch_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/views/product_details.dart';

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
        title: const Text("CheckOut"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child:
            BlocBuilder<FetchInvoiceFirestoreCubit, FetchInvoiceFirestoreState>(
          builder: (context, state) {
            if (state is FetchInvoiceFirestoreLoading) {
              print("Loading");
            }
            if (state is FetchInvoiceFirestoreLoaded) {
              return ListView.builder(
                  itemCount: state.allorders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent.shade100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      "Products Quantity: ${state.allorders[index].data.products.length}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Total Price: \$${state.allorders[index].data.totalPrice.toStringAsFixed(2)}",
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
                                "Discount: ${state.allorders[index].data.discount}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Net Total: \$${(state.allorders[index].data.nettotal).toStringAsFixed(2)}",
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
                                  child: BlocBuilder<FetchInvoiceFirestoreCubit,
                                      FetchInvoiceFirestoreState>(
                                    builder: (context, state) {
                                      if (state
                                          is FetchInvoiceFirestoreLoaded) {
                                        return Container(
                                          height: 25,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              state
                                                  .allorders[index].data.status,
                                              style: TextStyle(
                                                  color: state.allorders[index]
                                                              .data.status ==
                                                          "pending"
                                                      ? Colors.orange
                                                      : state
                                                                  .allorders[
                                                                      index]
                                                                  .data
                                                                  .status ==
                                                              "Confirm"
                                                          ? Colors.green
                                                          : Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox(
                                        height: 0,
                                        width: 0,
                                      );
                                    },
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.move_up_rounded,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        (MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                  orderId: state
                                                      .allorders[index].orderId,
                                                ))));
                                  },
                                )),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                    child: InkWell(
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.delete_outlined,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                  onTap: () {},
                                ))
                              ],
                            ),
                          )),
                          Expanded(child: BlocBuilder<
                              FetchInvoiceFirestoreCubit,
                              FetchInvoiceFirestoreState>(
                            builder: (context, state) {
                              if (state is FetchInvoiceFirestoreLoaded) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                          ),
                                          onTap: () {
                                            context
                                                .read<
                                                    FetchInvoiceFirestoreCubit>()
                                                .updateStatus(
                                                    status: 'Cancel',
                                                    productId: state
                                                        .allorders[index]
                                                        .orderId);
                                          },
                                        ),
                                      )),
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            child: const Text(
                                              "Confirm",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                            onTap: () {
                                              context
                                                  .read<
                                                      FetchInvoiceFirestoreCubit>()
                                                  .updateStatus(
                                                      status: 'Confirm',
                                                      productId: state
                                                          .allorders[index]
                                                          .orderId);
                                            },
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            },
                          )),
                        ],
                      ),
                    );
                  });
            }
            return const SizedBox(
              height: 0,
              width: 0,
            );
          },
        ),
      ),
    );
  }
}

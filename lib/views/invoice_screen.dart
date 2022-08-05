import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/add_invoice_firestore/add_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/views/checkout_screen.dart';

import '../models/products_model/products_model.dart';

class InvoiceScreen extends StatefulWidget {
  final List<ProductModel> productsInvoice;
  const InvoiceScreen({Key? key, required this.productsInvoice})
      : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckOutScreen()));
                },
                icon: const Icon(Icons.shopping_cart_checkout_outlined))
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child:
              BlocBuilder<AddInvoiceFirestoreCubit, AddInvoiceFirestoreState>(
            builder: (context, state) {
              if (state is AddInvoiceLoading) {
                print("loading");
              }
              if (state is AddInvoiceLoaded) {
                print("loaded");
              }
              return InkWell(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                      child: Text(
                    "CheckOut",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                ),
                onTap: () {
                  context.read<AddInvoiceFirestoreCubit>().addInvoiceData(
                      widget.productsInvoice,
                      getTotalPrice(),
                      20,
                      getTotalPrice() - (20 / 100) * getTotalPrice());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (index) => const CheckOutScreen()));
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: const [
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Price",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ))
                ],
              ),
              ListView.builder(
                  itemCount: widget.productsInvoice.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 80,
                      width: 80,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                        widget.productsInvoice[index].name)),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "Quantity:${widget.productsInvoice[index].qunatity}")),
                                        ),
                                        Expanded(
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    "\$${widget.productsInvoice[index].price}"))),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.orangeAccent,
                            thickness: 2,
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 120,
                child: Column(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text(
                              "Total Price:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "\$${getTotalPrice().toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 18),
                                )))
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: const [
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Discount:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "20 %",
                                  style: TextStyle(fontSize: 18),
                                )))
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        const Expanded(
                            flex: 3,
                            child: Text(
                              "Net total:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "\$${(getTotalPrice() - (20 / 100) * getTotalPrice()).toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 18),
                                )))
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  num getTotalPrice() {
    num total = 0;
    for (var p in widget.productsInvoice) {
      total += double.parse(p.price) * p.qunatity;
    }
    return total;
  }
}

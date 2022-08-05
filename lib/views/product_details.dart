import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/update_invoice_firestore/update_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/models/products_model/firebase_product_models/orders_product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String orderId;
  const ProductDetailsScreen({Key? key, required this.orderId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UpdateInvoiceFirestoreCubit>().listenInvoice(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return BlocBuilder<UpdateInvoiceFirestoreCubit,
                  UpdateInvoiceFirestoreState>(
                builder: (context, state) {
                  if (state is UpdateInvoiceFirestoreUpdated) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      height: 200,
                      width: 370,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Image.network(
                                    state.orderDetails.data.products[index]
                                        .image,
                                  )),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          state.orderDetails.data
                                              .products[index].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                state
                                                    .orderDetails
                                                    .data
                                                    .products[index]
                                                    .description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ))
                                ],
                              )),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  const Expanded(
                                      child: Text("Price",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black38))),
                                  Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                            state.orderDetails.data
                                                .products[index].price,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: const [
                                  Expanded(
                                      child: Text("In Stock",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black38))),
                                  Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text("10",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.orangeAccent),
                                      ),
                                    ),
                                    onTap: () {
                                      var model = state.orderDetails;
                                      model.data.products[index].qunatity--;
                                      num total = getTotalPrice(model);
                                      num netTotal = total - (20 / 100) * total;
                                      model.data.nettotal = netTotal.toDouble();
                                      model.data.totalPrice = total.toDouble();
                                      context
                                          .read<UpdateInvoiceFirestoreCubit>()
                                          .updateInvoice(model);
                                    },
                                  )),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "${state.orderDetails.data.products[index].qunatity}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  )),
                                  Expanded(
                                      child: InkWell(
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    onTap: () {
                                      var model = state.orderDetails;
                                      model.data.products[index].qunatity++;
                                      num total = getTotalPrice(model);
                                      num netTotal = total - (20 / 100) * total;
                                      model.data.nettotal = netTotal.toDouble();
                                      model.data.totalPrice = total.toDouble();
                                      context
                                          .read<UpdateInvoiceFirestoreCubit>()
                                          .updateInvoice(model);
                                    },
                                  ))
                                ],
                              ))
                            ],
                          ))
                        ],
                      ),
                    );
                  }
                  if (state is UpdateInvoiceFirestoreUpdating) {}
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              );
            }));
  }

  getTotalPrice(OrderModel model) {
    num totalprice = 0;
    for (var product in model.data.products) {
      totalprice += double.parse(product.price) * product.qunatity;
    }
    return totalprice;
  }
}

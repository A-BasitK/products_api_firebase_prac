import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:products_api_firebase_prac/controllers/products_cubits/product_controller_cubit.dart';
import 'package:products_api_firebase_prac/models/products_model/products_model.dart';
import 'package:products_api_firebase_prac/views/invoice_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: BlocBuilder<ProductControllerCubit, ProductControllerState>(
          builder: (context, state) {
            if (state is ProductControllerLoaded) {
              return InkWell(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                      child: Text(
                    "Proceed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceScreen(
                                productsInvoice: state.loadedData,
                              )));
                },
              );
            }
            return const SizedBox(
              height: 0,
              width: 0,
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: ListView(
          children: [
            BlocBuilder<ProductControllerCubit, ProductControllerState>(
              builder: (context, state) {
                if (state is ProductControllerLoaded) {
                  return Container(
                      height: 55,
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TypeAheadField(
                          textFieldConfiguration: const TextFieldConfiguration(
                            decoration: InputDecoration(
                              labelText: "Search Product",
                            ),
                          ),
                          suggestionsCallback: (String pattern) {
                            List<ProductModel> tempData = [];
                            for (var d in state.loadedData) {
                              if (d.name
                                  .toLowerCase()
                                  .startsWith(pattern.toLowerCase())) {
                                tempData.add(d);
                              }
                            }
                            return tempData;
                          },
                          itemBuilder: (context, ProductModel product) {
                            return ListTile(
                              title: Text(product.name),
                            );
                          },
                          onSuggestionSelected: (Object? suggestion) {},
                        ),
                        // child: TextField(
                        //   decoration: InputDecoration(
                        //       hintText: "Search Product Here..",
                        //       suffixIcon: Icon(Icons.search)),
                        // ),
                      ));
                }
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              },
            ),
            const SizedBox(
              height: 6,
            ),
            BlocBuilder<ProductControllerCubit, ProductControllerState>(
              builder: (context, state) {
                if (state is ProductControllerLoading) {
                  return const Center(
                    heightFactor: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      color: Colors.orangeAccent,
                    ),
                  );
                }

                if (state is ProductControllerLoaded) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.loadedData.length,
                      itemBuilder: (context, index) {
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
                                offset:
                                    Offset(0, 1), // changes position of shadow
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
                                          child: Image.network(state
                                              .loadedData[index].imageLink)),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              state.loadedData[index].name,
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
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Text(
                                                    state.loadedData[index]
                                                        .description,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                "\$${state.loadedData[index].price}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                          context
                                              .read<ProductControllerCubit>()
                                              .decrementProduct(
                                                  state.loadedData, index);
                                        },
                                      )),
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            state.loadedData[index].qunatity
                                                .toString(),
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
                                          context
                                              .read<ProductControllerCubit>()
                                              .incrementProduct(
                                                  state.loadedData, index);
                                        },
                                      ))
                                    ],
                                  ))
                                ],
                              ))
                            ],
                          ),
                        );
                      });
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

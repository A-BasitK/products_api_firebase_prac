import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/add_invoice_firestore/add_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/fetch_invoice_firestore/fetch_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/firebase_storage/image_firebase_storage_cubit.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/firebase_storage_fetching/image_storage_fetch_cubit.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/update_invoice_firestore/update_invoice_firestore_cubit.dart';
import 'package:products_api_firebase_prac/controllers/products_cubits/product_controller_cubit.dart';
import 'package:products_api_firebase_prac/views/image_storage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductControllerCubit()),
        BlocProvider(create: (context) => AddInvoiceFirestoreCubit()),
        BlocProvider(create: (context) => FetchInvoiceFirestoreCubit()),
        BlocProvider(create: (context) => UpdateInvoiceFirestoreCubit()),
        BlocProvider(create: (context) => ImageFirebaseStorageCubit()),
        BlocProvider(create: (context) => ImageStorageFetchCubit())
      ],
      child: const MaterialApp(
        home: ImageStorage(),
      ),
    );
  }
}

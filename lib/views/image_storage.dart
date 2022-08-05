import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/firebase_storage/image_firebase_storage_cubit.dart';
import 'package:products_api_firebase_prac/controllers/firestore_cubits/firebase_storage_fetching/image_storage_fetch_cubit.dart';

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  State<ImageStorage> createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Storage"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ListView(
          children: [
            BlocBuilder<ImageStorageFetchCubit, ImageStorageFetchState>(
              builder: (context, state) {
                if (state is ImageStorageFetchLoading) {
                  print("Loading");
                }
                if (state is ImageStorageFetchLoaded) {
                  return SizedBox(
                    height: 300,
                    child: PageView.builder(
                        clipBehavior: Clip.antiAlias,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.imageListing.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(state.imageListing[index]),
                            ),
                          );
                        }),
                  );
                }
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              child: InkWell(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.teal,
                  ),
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select Image",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                onTap: () {
                  context.read<ImageFirebaseStorageCubit>().uploadImage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

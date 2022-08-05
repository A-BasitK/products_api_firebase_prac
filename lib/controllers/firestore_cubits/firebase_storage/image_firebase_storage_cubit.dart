import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_firebase_storage_state.dart';

class ImageFirebaseStorageCubit extends Cubit<ImageFirebaseStorageState> {
  ImageFirebaseStorageCubit() : super(ImageFirebaseStorageInitial());

  uploadImage() async {
    emit(ImageFirebaseStorageUploading());
    try {
      final firebaseStorage = FirebaseStorage.instance;
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      var file = File(image!.path);
      var ref = firebaseStorage.ref().child("images/${image.name}");
      var uploadImage = await ref.putFile(file);
      var location = await uploadImage.ref.getDownloadURL();
      emit(ImageFirebaseStorageUploaded());
      await FirebaseFirestore.instance
          .collection("images")
          .add({'img': location});
    } catch (e) {
      emit(ImageFirebaseStorageError(err: e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'image_storage_fetch_state.dart';

class ImageStorageFetchCubit extends Cubit<ImageStorageFetchState> {
  ImageStorageFetchCubit() : super(ImageStorageFetchInitial()) {
    showImage();
  }

  showImage() {
    emit(ImageStorageFetchLoading());
    try {
      List<String> imageList = [];
      var ref = FirebaseFirestore.instance.collection("images").snapshots();
      ref.listen((event) {
        imageList.clear();
        for (var d in event.docs) {
          imageList.add(d.data()['img']);
        }
        emit(ImageStorageFetchLoaded(imageListing: imageList));
      });
    } catch (e) {}
  }
}

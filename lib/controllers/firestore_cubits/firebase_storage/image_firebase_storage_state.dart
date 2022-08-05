part of 'image_firebase_storage_cubit.dart';

@immutable
abstract class ImageFirebaseStorageState {}

class ImageFirebaseStorageInitial extends ImageFirebaseStorageState {}

class ImageFirebaseStorageUploading extends ImageFirebaseStorageState {}

class ImageFirebaseStorageUploaded extends ImageFirebaseStorageState {}

class ImageFirebaseStorageError extends ImageFirebaseStorageState {
  final String err;
  ImageFirebaseStorageError({required this.err});
}

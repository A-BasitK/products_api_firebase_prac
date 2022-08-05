part of 'image_storage_fetch_cubit.dart';

@immutable
abstract class ImageStorageFetchState {}

class ImageStorageFetchInitial extends ImageStorageFetchState {}

class ImageStorageFetchLoading extends ImageStorageFetchState {}

class ImageStorageFetchLoaded extends ImageStorageFetchState {
  final List<String> imageListing;
  ImageStorageFetchLoaded({required this.imageListing});
}

class ImageStorageFetchError extends ImageStorageFetchState {
  final String err;
  ImageStorageFetchError({required this.err});
}

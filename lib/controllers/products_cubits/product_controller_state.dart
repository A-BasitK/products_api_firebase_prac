part of 'product_controller_cubit.dart';

@immutable
abstract class ProductControllerState {}

class ProductControllerInitial extends ProductControllerState {}
class ProductControllerLoading extends ProductControllerState {}
class ProductControllerLoaded extends ProductControllerState {
  List<ProductModel> loadedData;
  ProductControllerLoaded({required this.loadedData});
}
class ProductControllerError extends ProductControllerState {
  String err;
  ProductControllerError({required this.err});
}

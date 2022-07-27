import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:products_api_firebase_prac/models/products_model/products_model.dart';
import 'package:products_api_firebase_prac/models/repository/product_repo/products_repo.dart';
import 'package:products_api_firebase_prac/views/products.dart';

part 'product_controller_state.dart';

class ProductControllerCubit extends Cubit<ProductControllerState> {
  ProductControllerCubit() : super(ProductControllerInitial()){
    getProduct();
  }
  getProduct()async{
    emit(ProductControllerLoading());
    try{
      final productData= await ProductRepo.getProductData();
      emit(ProductControllerLoaded(loadedData: productData!));
    }catch(e){
      emit(ProductControllerError(err: e.toString()));
    }

  }
  incrementProduct( List<ProductModel> products,int index){
    products[index].qunatity++;
    emit(ProductControllerLoaded(loadedData: products));
  }
  decrementProduct(List<ProductModel> products,int index){
    products[index].qunatity--;
    emit(ProductControllerLoaded(loadedData: products));

  }

}

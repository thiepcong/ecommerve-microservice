import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  void addQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void subQuantity() {
    emit(state.copyWith(quantity: state.quantity - 1));
  }
}

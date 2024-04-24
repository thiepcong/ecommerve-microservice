import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/product_detail_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._repo) : super(const ProductDetailState());

  final ProductDetailRepository _repo;

  void addQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void subQuantity() {
    emit(state.copyWith(quantity: state.quantity - 1));
  }

  void addToCart(String productId, String type) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      await _repo.addToCart(
        quantity: state.quantity,
        type: type,
        productId: productId,
      );
      emit(state.copyWith(
        message: "Thêm sản phẩm thành công",
        isLoading: false,
      ));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: e.message, isLoading: false));
        return;
      }
      emit(state.copyWith(message: "Đã có lỗi xảy ra!", isLoading: false));
      rethrow;
    }
  }
}

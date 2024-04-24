import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/product.dart';
import '../../../network/exceptions/bad_request_exception.dart';
import '../repository/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._repo) : super(const CartState());

  final CartRepository _repo;

  void init() {
    final li = [
      CartItemModel(
          product: Product(
            image:
                'https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390',
            des: 'dsadsa',
            price: 100000,
            title: 'oke',
          ),
          quantity: 5),
      CartItemModel(
          product: Product(
            image:
                'https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390',
            des: 'dsadsa',
            price: 100000,
            title: 'oke',
          ),
          quantity: 5),
      CartItemModel(
          product: Product(
            image:
                'https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390',
            des: 'dsadsa',
            price: 100000,
            title: 'oke',
          ),
          quantity: 5),
    ];
    emit(state.copyWith(carts: li));
  }

  void addQuantity(CartItemModel e, int index) {
    final x = e.copyWith(quantity: e.quantity + 1);
    List<CartItemModel> li = List.from(state.carts);
    li[index] = x;
    updateCartItem(
      productId: x.product.id,
      quantity: x.quantity,
      type: e.product.type,
    );
    emit(state.copyWith(carts: li));
  }

  void subQuantity(CartItemModel e, int index) {
    final x = e.copyWith(quantity: e.quantity - 1);
    List<CartItemModel> li = List.from(state.carts);
    li[index] = x;
    updateCartItem(
      productId: x.product.id,
      quantity: x.quantity,
      type: e.product.type,
    );
    emit(state.copyWith(carts: li));
  }

  void setChooseCartItem(CartItemModel e, int index, bool? isChoose) {
    final x = e.copyWith(isChoose: isChoose);
    List<CartItemModel> li = List.from(state.carts);
    li[index] = x;
    emit(state.copyWith(carts: li));
  }

  void removeCartItem(int index) async {
    List<CartItemModel> li = List.from(state.carts);
    final res = li.removeAt(index);
    await deleteCartItem(res.product.id);
    emit(state.copyWith(carts: li));
  }

  void handleChooseAll(bool? e) {
    List<CartItemModel> li = List.from(state.carts);
    for (int i = 0; i < li.length; i++) {
      li[i] = li[i].copyWith(isChoose: e);
    }
    emit(state.copyWith(carts: li));
  }

  void getAllCartItem() async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _repo.getAllCartItem();
      emit(state.copyWith(isLoading: false, carts: res.cartItems));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: e.message, isLoading: false));
        return;
      }
      emit(state.copyWith(message: "Đã có lỗi xảy ra!", isLoading: false));
      rethrow;
    }
  }

  void updateCartItem({
    required int quantity,
    required String productId,
    required String type,
  }) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      await _repo.updateCartItem(
        quantity: quantity,
        type: type,
        productId: productId,
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      if (e is BadRequestException) {
        emit(state.copyWith(message: e.message, isLoading: false));
        return;
      }
      emit(state.copyWith(message: "Đã có lỗi xảy ra!", isLoading: false));
      rethrow;
    }
  }

  Future deleteCartItem(String productId) async {
    try {
      emit(state.copyWith(message: null, isLoading: true));
      final res = await _repo.deleteCartItem(productId: productId);
      emit(state.copyWith(isLoading: false, message: res));
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

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/product.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

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
    emit(state.copyWith(carts: li));
  }

  void subQuantity(CartItemModel e, int index) {
    final x = e.copyWith(quantity: e.quantity - 1);
    List<CartItemModel> li = List.from(state.carts);
    li[index] = x;
    emit(state.copyWith(carts: li));
  }

  void setChooseCartItem(CartItemModel e, int index, bool? isChoose) {
    final x = e.copyWith(isChoose: isChoose);
    List<CartItemModel> li = List.from(state.carts);
    li[index] = x;
    emit(state.copyWith(carts: li));
  }

  void removeCartItem(int index) {
    List<CartItemModel> li = List.from(state.carts);
    li.removeAt(index);
    emit(state.copyWith(carts: li));
  }

  void handleChooseAll(bool? e) {
    List<CartItemModel> li = List.from(state.carts);
    for (int i = 0; i < li.length; i++) {
      li[i] = li[i].copyWith(isChoose: e);
    }
    emit(state.copyWith(carts: li));
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const ProductDetailState._();

  const factory ProductDetailState({
    @Default(false) bool isLoading,
    @Default(1) int quantity,
    String? message,
    Error? error,
  }) = _ProductDetailState;
}

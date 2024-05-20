import 'package:ecommerce_flutter/app/network/exceptions/bad_request_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/models.dart';
import '../../../core/models/secret.dart';
import '../../order/api/paypal_payment.dart';
import '../repository/product_detail_repository.dart';
import 'product_detail_state.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

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

  Future<void> paypalPayment() async {
    PaypalSecret secret = PaypalSecret(
      clientId: Secret.clientIdSandbox,
      clientSecret: Secret.clientSecretSandbox,
      paymentMode: PaymentMode.sandbox,
    );

    PaypalPayment paymentService = PaypalPayment(paypalSecret: secret);

    Token token = await paymentService.getAccessToken(secret);

    if (token.token == null) {
      return;
    }
    Payment payment = await paymentService.createPayment(
      transactionSubscription(),
      token.token!,
    );
    if (payment.approvalUrl == null) {
      return;
    }
    // html.window.open(payment.approvalUrl!, "Payment");
    openURLInCurrentTab(payment.approvalUrl!);
  }

  void openURLInCurrentTab(String url) {
    js.context.callMethod('open', [url, '_self']);
  }
}

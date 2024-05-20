import 'package:ecommerce_flutter/app/core/models/address.dart';
import 'package:ecommerce_flutter/app/core/models/carrier.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/models.dart';
import '../../../core/models/payment_method.dart';
import '../../../core/models/secret.dart';
import '../api/paypal_payment.dart';
import '../repository/order_repository.dart';
import 'order_state.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._repo) : super(const OrderState());

  final OrderRepository _repo;

  void init(List<CartItemModel> carts) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.getAllAddress();
      final res2 = await _repo.getAllCarrier();
      final res3 = await _repo.getAllPaymentMethod();
      emit(state.copyWith(
        carts: carts,
        addresses: res,
        carriers: res2,
        paymentMethods: res3,
        isLoading: false,
        currentAddress: res.isNotEmpty ? res.first : null,
        currentCarrier: res2.isNotEmpty ? res2.first : null,
        currentPaymentMethod: res3.isNotEmpty ? res3.first : null,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }

  void setCurrentAddress(Address e) {
    emit(state.copyWith(currentAddress: e));
  }

  void setCurrentCarrier(Carrier e) {
    emit(state.copyWith(currentCarrier: e));
  }

  void setPaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(currentPaymentMethod: paymentMethod));
  }

  Future<void> paypalPayment({double? price}) async {
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
      transactionSubscription(price: price),
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

  void addOrder(double totalPay) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final res = await _repo.orderHandle(
        address: state.currentAddress!,
        carrier: state.currentCarrier!,
        carts: state.carts,
        paymentMethod: state.currentPaymentMethod!,
      );

      if (state.currentPaymentMethod!.id == 1) {
        // emit(state.copyWith(isLoading: false));
        final pre = await SharedPreferences.getInstance();
        await pre.setInt("orderId", res);
        paypalPayment(price: totalPay);
      } else {
        emit(state.copyWith(isLoading: false, message: "Đặt hàng thành công"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: "Đã có lỗi xảy ra"));
      rethrow;
    }
  }
}

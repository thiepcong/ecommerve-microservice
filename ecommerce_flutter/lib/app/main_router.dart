import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_routes.dart';
import 'core/models/cart_item_model.dart';
import 'core/models/product.dart';
import 'modules/cart/view/cart_view.dart';
import 'modules/home/view/home_view.dart';
import 'modules/login/view/login_view.dart';
import 'modules/login/view/register_view.dart';
import 'modules/order/view/order_view.dart';
import 'modules/order_handle/view/order_handle_view.dart';
import 'modules/order_handle/view/payment_paypal_cancel_view.dart';
import 'modules/order_handle/view/payment_paypal_success_view.dart';
import 'modules/product_detail/view/product_detail_view.dart';
import 'modules/purchase/view/purchase_view.dart';
import 'modules/user_info/view/user_info_view.dart';
part 'main_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LoginView, path: Routes.login, initial: true),
    MaterialRoute(page: HomeView, path: Routes.home),
    MaterialRoute(page: RegisterView, path: Routes.register),
    MaterialRoute(page: ProductDetailView, path: Routes.productDetail),
    MaterialRoute(page: CartView, path: Routes.cart),
    MaterialRoute(page: UserInfoView, path: Routes.userInfo),
    MaterialRoute(page: OrderView, path: Routes.order),
    MaterialRoute(
        page: PaymentPaypalSuccessView, path: Routes.paymentPaypalSuccess),
    MaterialRoute(
        page: PaymentPaypalCancelView, path: Routes.paymentPaypalCancel),
    MaterialRoute(page: OrderHandleView, path: Routes.orderHandle),
    MaterialRoute(page: PurchaseView, path: Routes.purchase),
  ],
)
class MainRouter extends _$MainRouter {
  MainRouter({
    GlobalKey<NavigatorState>? navigatorKey,
  }) : super(navigatorKey);
}

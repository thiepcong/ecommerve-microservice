import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/cart_item_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import '../repository/order_repository.dart';
import '../widgets/address_item.dart';
import '../widgets/carriers_item.dart';
import '../widgets/list_product_item.dart';
import '../widgets/payment_item.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, this.carts});

  final List<CartItemModel>? carts;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Đặt hàng và thanh toán',
      child: BlocProvider(
        create: (_) => OrderCubit(context.read<OrderRepository>())
          ..init(widget.carts ?? []),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderCubit, OrderState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message ?? '');
            }
            if (state.message == "Đặt hàng thành công") {
              context.pushRoute(const OrderHandleViewRoute());
            }
          },
        ),
      ],
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(label: 'Đặt hàng và thanh toán'),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  opacity: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  const SingleChildScrollView(
                    child: Column(
                      children: [
                        AddressItem(),
                        ListProductItem(),
                        CarriersItem(),
                        PaymentItem(),
                      ],
                    ),
                  ),
                  state.isLoading
                      ? Container(
                          color: AppColors.colorFF000000.withOpacity(0.5),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';

import '../../../core/models/cart_item_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';

class ListProductItem extends StatelessWidget {
  const ListProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderCubit, OrderState, List<CartItemModel>>(
      selector: (state) => state.carts,
      builder: (context, carts) {
        return Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
          decoration: const BoxDecoration(
            color: AppColors.colorFFFFFFFF,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Sản phẩm",
                      style: TextStyles.mediumMWhiteS20
                          .copyWith(color: AppColors.colorFF000000),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 150),
                    child: Text(
                      "Đơn giá",
                      style: TextStyles.regularBlackS14,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 136),
                    child: Text(
                      "Số lượng",
                      style: TextStyles.regularBlackS14,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 70),
                    child: Text(
                      "Thành tiền",
                      style: TextStyles.regularBlackS14,
                    ),
                  ),
                ],
              ),
              ...carts.map((e) => OrderProductItem(item: e)).toList()
            ],
          ),
        );
      },
    );
  }
}

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 24),
          Expanded(
            child: Row(
              children: [
                ImageNetwork(
                  image: "http://127.0.0.1:4002${item.product.image}",
                  height: 100,
                  width: 100,
                  duration: 1500,
                  curve: Curves.easeIn,
                  onPointer: true,
                  debugPrint: false,
                  fullScreen: false,
                  fitAndroidIos: BoxFit.cover,
                  fitWeb: BoxFitWeb.cover,
                  // borderRadius: BorderRadius.circular(4),
                  onLoading: const CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  ),
                  onError: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    item.product.title,
                    style: TextStyles.regularBlackS14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${item.product.price.formatCurrency()} đ",
                      style: TextStyles.regularBlackS14,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.quantity.toString(),
                    style: TextStyles.regularBlackS14,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${(item.product.price * item.quantity).formatCurrency()} đ",
                      style: TextStyles.regularBlackS14
                          .copyWith(color: AppColors.colorFFf7472f),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

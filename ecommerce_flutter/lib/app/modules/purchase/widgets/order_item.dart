import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:ecommerce_flutter/app/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';

import '../../../core/models/order_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../cubit/purchase_cubit.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.item});

  final OrderModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: const BoxDecoration(
        color: AppColors.colorFFFFFFFF,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item.isCancel
                ? "ĐÃ HUỶ"
                : item.status
                    ? "HOÀN THÀNH"
                    : "CHƯA HOÀN THÀNH",
            style: TextStyles.regularWhiteS20.copyWith(
                color: item.isCancel
                    ? AppColors.colorFF000000
                    : AppColors.colorFFf7472f),
          ),
          const Divider(color: AppColors.colorFFC5C5C5),
          ...item.orderItem
              .map((e) => Column(
                    children: [
                      Row(
                        children: [
                          ImageNetwork(
                            image: "http://127.0.0.1:4002${e.product.image}",
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.product.title,
                                  style: TextStyles.regularBlackS14,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Text(
                                  'x ${e.quantity}',
                                  style: TextStyles.smallBlackS14,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${(e.price * e.quantity).formatCurrency()} đ",
                            style: TextStyles.regularBlackS14
                                .copyWith(color: AppColors.colorFFf7472f),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.colorFFC5C5C5),
                    ],
                  ))
              .toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.privacy_tip,
                color: AppColors.colorFFf7472f,
              ),
              const Text(
                "Thành tiền: ",
                style: TextStyles.smallBlackS14,
              ),
              Text(
                "${(item.total).formatCurrency()} đ",
                style: TextStyles.boldWhiteS28
                    .copyWith(color: AppColors.colorFFf7472f),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  onTap: () {
                    context.pushRoute(ProductDetailViewRoute(
                        item: item.orderItem.first.product));
                  },
                  title: "Mua lại",
                  backgroundColor: AppColors.colorFFf7472f,
                  textColor: AppColors.colorFFFFFFFF,
                  textSize: 16,
                  borderColor: AppColors.colorFFf7472f,
                ),
              ),
              const SizedBox(width: 32),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  onTap: () {
                    context.read<PurchaseCubit>().cancelOrder(item.id);
                  },
                  title: "Huỷ đơn hàng",
                  backgroundColor: AppColors.transparent,
                  textColor: AppColors.colorFF000000,
                  textSize: 16,
                  borderColor: AppColors.colorFF000000,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

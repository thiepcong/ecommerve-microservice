import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:ecommerce_flutter/app/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final cubit = context.read<OrderCubit>();
        final li = state.carts.where((element) => element.isChoose).toList();
        final totalPay = li.isEmpty
            ? 0.toDouble()
            : li
                .map((e) => e.product.price * e.quantity)
                .reduce((value, element) => value + element);
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
                      "Phương thức thanh toán",
                      style: TextStyles.mediumMWhiteS20
                          .copyWith(color: AppColors.colorFF000000),
                    ),
                  ),
                  PaymentMethodItem(
                    onTap: () => cubit,
                    label: "Paypal",
                    isChoose: false,
                  ),
                  PaymentMethodItem(
                    onTap: () {},
                    label: "Thanh toán khi nhận hàng",
                    isChoose: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: AppColors.colorFFC5C5C5),
              const SizedBox(height: 100),
              const Divider(color: AppColors.colorFFC5C5C5),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: SizedBox.shrink()),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng tiền hàng",
                              style: TextStyles.regularBlackS14,
                            ),
                            Text(
                              "${totalPay.formatCurrency()} đ",
                              style: TextStyles.regularBlackS14,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Phí vận chuyển",
                              style: TextStyles.regularBlackS14,
                            ),
                            Text(
                              "${(state.currentCarrier?.price ?? 0).formatCurrency()} đ",
                              style: TextStyles.regularBlackS14,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng thanh toán",
                              style: TextStyles.regularBlackS14,
                            ),
                            Text(
                              "${(totalPay + (state.currentCarrier?.price ?? 0)).formatCurrency()} đ",
                              style: TextStyles.mediumBlackS20.copyWith(
                                  color: AppColors.colorFFf7472f, fontSize: 28),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Divider(color: AppColors.colorFFC5C5C5),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 240,
                  child: PrimaryButton(
                    onTap: () {},
                    title: "Đặt hàng",
                    backgroundColor: AppColors.colorFFf7472f,
                    textColor: AppColors.colorFFFFFFFF,
                    textSize: 16,
                    borderColor: AppColors.colorFFf7472f,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    this.onTap,
    required this.label,
    required this.isChoose,
  });

  final VoidCallback? onTap;
  final String label;
  final bool isChoose;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.colorFFFFFFFF,
            border: Border.all(
                color: isChoose
                    ? AppColors.colorFFf7472f
                    : AppColors.colorFFC5C5C5),
          ),
          child: Text(
            label,
            style: TextStyles.regularBlackS14
                .copyWith(color: isChoose ? AppColors.colorFFf7472f : null),
          ),
        ));
  }
}

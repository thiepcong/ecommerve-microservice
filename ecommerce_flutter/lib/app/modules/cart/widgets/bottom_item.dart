import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/models/cart_item_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    this.onChanged,
    required this.value,
    required this.carts,
    this.onBuy,
  });

  final void Function(bool?)? onChanged;
  final bool value;
  final List<CartItemModel> carts;
  final VoidCallback? onBuy;

  @override
  Widget build(BuildContext context) {
    final lenChoose = carts.where((element) => element.isChoose).length;
    final li = carts.where((element) => element.isChoose).toList();
    final totalPay = li.isEmpty
        ? 0.toDouble()
        : li
            .map((e) => e.product.price * e.quantity)
            .reduce((value, element) => value + element);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: const BoxDecoration(
        color: AppColors.colorFFFFFFFF,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.colorFFf7472f,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              "Chọn tất cả (${carts.length})",
              style: TextStyles.regularBlackS14,
            ),
          ),
          Text(
            "Tổng thanh toán ($lenChoose sản phẩm):",
            style: TextStyles.regularBlackS14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "${totalPay.formatCurrency()} đ",
              style: TextStyles.regularBlackS14
                  .copyWith(color: AppColors.colorFFf7472f),
            ),
          ),
          InkWell(
            onTap: () => onBuy?.call(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: AppColors.colorFFf7472f,
              ),
              child: Text(
                "Mua",
                style: TextStyles.regularBlackS14
                    .copyWith(color: AppColors.colorFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

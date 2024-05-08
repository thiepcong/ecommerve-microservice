import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

import '../../../core/models/cart_item_model.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    this.onChanged,
    this.onAdd,
    this.onSub,
    this.onDelete,
    required this.item,
  });

  final CartItemModel item;
  final void Function(bool?)? onChanged;
  final VoidCallback? onAdd;
  final VoidCallback? onSub;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      decoration: const BoxDecoration(
        color: AppColors.colorFFFFFFFF,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.isChoose,
            onChanged: onChanged,
            activeColor: AppColors.colorFFf7472f,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Row(
              children: [
                ImageNetwork(
                  image:
                      "http://127.0.0.1:4002${item.product.image}",
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
                  child: QuantityCartItem(
                    num: item.quantity,
                    onAdd: onAdd,
                    onSub: onSub,
                    maxQuantity: item.product.quantity,
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
                InkWell(
                  onTap: () => onDelete?.call(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      "Xoá",
                      style: TextStyles.regularBlackS14,
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

class QuantityCartItem extends StatelessWidget {
  const QuantityCartItem({
    super.key,
    required this.num,
    this.onAdd,
    this.onSub,
    required this.maxQuantity,
  });

  final int num;
  final VoidCallback? onAdd;
  final VoidCallback? onSub;
  final int maxQuantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorFF475467),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: num > 1 ? () => onSub?.call() : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "-",
                style: TextStyles.boldBlackS28,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 36,
            color: AppColors.colorFF475467,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                num.toString(),
                style: TextStyles.mediumBlackS20,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 36,
            color: AppColors.colorFF475467,
          ),
          InkWell(
            onTap: num < maxQuantity ? () => onAdd?.call() : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "+",
                style: TextStyles.boldBlackS28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

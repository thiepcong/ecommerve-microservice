import 'package:flutter/material.dart';

import '../../../core/values/text_styles.dart';

class QuantityItem extends StatelessWidget {
  const QuantityItem({
    super.key,
    this.onSub,
    this.onAdd,
    required this.quantity,
  });

  final VoidCallback? onSub;
  final VoidCallback? onAdd;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Số lượng: ",
          style: TextStyles.mediumBlackS20,
        ),
        Expanded(
            child: Row(
          children: [
            QuantityButtonItem(
              onTap: () => onSub?.call(),
              number: '-',
              canTap: quantity > 1,
            ),
            QuantityButtonItem(number: quantity.toString()),
            QuantityButtonItem(
              onTap: () => onAdd?.call(),
              number: '+',
              canTap: quantity < 10,
            ),
          ],
        )),
      ],
    );
  }
}

class QuantityButtonItem extends StatelessWidget {
  const QuantityButtonItem({
    super.key,
    required this.number,
    this.onTap,
    this.canTap = false,
  });
  final String number;
  final VoidCallback? onTap;
  final bool canTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: canTap ? () => onTap?.call() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Text(
          number.toString(),
          style: TextStyles.boldBlackS28.copyWith(fontSize: 24),
        ),
      ),
    );
  }
}

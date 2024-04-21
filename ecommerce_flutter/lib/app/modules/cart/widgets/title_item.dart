import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({
    super.key,
    this.onChanged,
    required this.value,
  });

  final void Function(bool?)? onChanged;
  final bool value;

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
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.colorFFf7472f,
          ),
          const SizedBox(width: 24),
          const Expanded(
            child: Text(
              "Sản phẩm",
              style: TextStyles.regularBlackS14,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 54),
            child: Text(
              "Đơn giá",
              style: TextStyles.regularBlackS14,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              "Số lượng",
              style: TextStyles.regularBlackS14,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              "Số tiền",
              style: TextStyles.regularBlackS14,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Thao tác",
              style: TextStyles.regularBlackS14,
            ),
          ),
        ],
      ),
    );
  }
}

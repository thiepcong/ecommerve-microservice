import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    this.onUpdate,
    this.onSetDefault,
    this.onDelete,
  });

  final String name;
  final String phone;
  final String address;
  final VoidCallback? onUpdate;
  final VoidCallback? onSetDefault;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyles.regularBlackS16,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    color: AppColors.colorFF424242,
                    width: 1,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    phone,
                    style: TextStyles.smallBlackS14
                        .copyWith(color: AppColors.colorFF424242, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                address,
                style: TextStyles.smallBlackS14
                    .copyWith(color: AppColors.colorFF424242),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorFFf7472f)),
                child: Text(
                  "Mặc định",
                  style: TextStyles.smallBlackS14
                      .copyWith(color: AppColors.colorFFf7472f),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => onUpdate?.call(),
                  child: const Text("Cập nhật"),
                ),
                TextButton(
                  onPressed: () => onDelete?.call(),
                  child: const Text("Xoá"),
                ),
              ],
            ),
            TextButton(
              onPressed: () => onSetDefault?.call(),
              child: const Text("Thiết lập mặc định"),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/models/address.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import 'address_popup.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.item,
    this.onUpdate,
    this.onDelete,
  });

  final Address item;
  final void Function(Address)? onUpdate;
  final void Function(Address)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.colorFF808089)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${item.fname} ${item.lname}",
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
                      item.mobile,
                      style: TextStyles.smallBlackS14.copyWith(
                          color: AppColors.colorFF424242, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.address,
                  style: TextStyles.smallBlackS14
                      .copyWith(color: AppColors.colorFF424242),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () => _showAddressPopup(
                  context,
                  address: item,
                  onDone: onUpdate,
                ),
                child: const Text("Cập nhật"),
              ),
              TextButton(
                onPressed: () => onDelete?.call(item),
                child: const Text("Xoá"),
              ),
              // Row(
              //   children: [
              //     TextButton(
              //       onPressed: () => onUpdate?.call(),
              //       child: const Text("Cập nhật"),
              //     ),
              //     TextButton(
              //       onPressed: () => onDelete?.call(),
              //       child: const Text("Xoá"),
              //     ),
              //   ],
              // ),
              // TextButton(
              //   onPressed: () => onSetDefault?.call(),
              //   child: const Text("Thiết lập mặc định"),
              // ),
            ],
          )
        ],
      ),
    );
  }

  void _showAddressPopup(
    BuildContext context, {
    Address? address,
    void Function(Address)? onDone,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          child: AddressPopup(address: address, onDone: onDone),
        );
      },
    );
  }
}

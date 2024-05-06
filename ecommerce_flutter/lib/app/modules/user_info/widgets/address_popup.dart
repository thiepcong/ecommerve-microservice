import 'package:ecommerce_flutter/app/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class AddressPopup extends StatefulWidget {
  const AddressPopup({super.key});

  @override
  State<AddressPopup> createState() => _AddressPopupState();
}

class _AddressPopupState extends State<AddressPopup> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.colorFFFFFFFF,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Địa chỉ mới",
            style: TextStyles.mediumBlackS20,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Họ và tên',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số điện thoại',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Địa chỉ',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: PrimaryButton(
                  onTap: () => Navigator.of(context).pop(),
                  title: "Trở lại",
                  backgroundColor: AppColors.colorFFFFFFFF,
                  textColor: AppColors.colorFF000000,
                  textSize: 16,
                  borderColor: AppColors.colorFFFFFFFF,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: PrimaryButton(
                  onTap: () {},
                  title: "Hoàn thành",
                  backgroundColor: AppColors.colorFFf7472f,
                  textColor: AppColors.colorFFFFFFFF,
                  textSize: 16,
                  borderColor: AppColors.colorFFf7472f,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

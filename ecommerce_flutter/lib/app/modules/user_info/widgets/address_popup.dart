import 'package:ecommerce_flutter/app/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/address.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';

class AddressPopup extends StatefulWidget {
  const AddressPopup({
    super.key,
    this.address,
    this.onDone,
  });

  final Address? address;
  final void Function(Address address)? onDone;

  @override
  State<AddressPopup> createState() => _AddressPopupState();
}

class _AddressPopupState extends State<AddressPopup> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    if (widget.address != null) {
      _fnameController.text = widget.address!.fname;
      _lnameController.text = widget.address!.lname;
      _phoneController.text = widget.address!.mobile;
      _addressController.text = widget.address!.address;
    }
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.address == null ? "Địa chỉ mới" : "Sửa địa chỉ",
            style: TextStyles.mediumBlackS20,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: _fnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Họ',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: TextFormField(
                  controller: _lnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tên',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Số điện thoại',
            ),
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
                  onTap: () async {
                    final pre = await SharedPreferences.getInstance();
                    final email = pre.getString("email") ?? '';
                    widget.onDone?.call(Address(
                      id: widget.address?.id ?? -1,
                      fname: _fnameController.text,
                      lname: _lnameController.text,
                      email: email,
                      mobile: _phoneController.text,
                      address: _addressController.text,
                    ));
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
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

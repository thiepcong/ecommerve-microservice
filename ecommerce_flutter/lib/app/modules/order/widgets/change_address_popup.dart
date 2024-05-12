import 'package:flutter/material.dart';

import '../../../core/models/address.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';

class ChangeAddressPopup extends StatefulWidget {
  const ChangeAddressPopup({
    super.key,
    this.onDone,
    this.currentAddress,
    required this.addresses,
  });

  final Address? currentAddress;
  final List<Address> addresses;
  final void Function(Address address)? onDone;

  @override
  State<ChangeAddressPopup> createState() => _ChangeAddressPopupState();
}

class _ChangeAddressPopupState extends State<ChangeAddressPopup> {
  int _selectedIndex = -1;

  @override
  void initState() {
    for (int i = 0; i < widget.addresses.length; i++) {
      if (widget.addresses[i].id == widget.currentAddress?.id) {
        setState(() {
          _selectedIndex = i;
        });
        break;
      }
    }
    super.initState();
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Địa chỉ của tôi",
              style: TextStyles.mediumBlackS20,
            ),
            const SizedBox(height: 24),
            ...widget.addresses
                .asMap()
                .entries
                .map((e) => ListAddressPopupItem(
                      selectedValue: _selectedIndex,
                      value: e.key,
                      item: e.value,
                      onChanged: (e) {
                        setState(() {
                          _selectedIndex = e ?? -1;
                        });
                      },
                    ))
                .toList(),
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
                      widget.onDone?.call(widget.addresses[_selectedIndex]);
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    title: "Xác nhận",
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
      ),
    );
  }
}

class ListAddressPopupItem extends StatelessWidget {
  const ListAddressPopupItem({
    super.key,
    this.onChanged,
    required this.selectedValue,
    required this.value,
    required this.item,
  });

  final void Function(int?)? onChanged;
  final int selectedValue;
  final int value;
  final Address item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            groupValue: selectedValue,
            onChanged: onChanged,
            value: value,
            activeColor: AppColors.colorFFf7472f,
          ),
        ),
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
                    style: TextStyles.smallBlackS14
                        .copyWith(color: AppColors.colorFF424242, fontSize: 12),
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
      ],
    );
  }
}

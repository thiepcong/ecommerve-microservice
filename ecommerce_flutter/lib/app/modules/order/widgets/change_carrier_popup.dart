import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:flutter/material.dart';
import '../../../core/models/carrier.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';

class ChangeCarrierPopup extends StatefulWidget {
  const ChangeCarrierPopup({
    super.key,
    this.onDone,
    this.currentCarrier,
    required this.carriers,
  });

  final Carrier? currentCarrier;
  final List<Carrier> carriers;
  final void Function(Carrier address)? onDone;

  @override
  State<ChangeCarrierPopup> createState() => _ChangeCarrierPopupState();
}

class _ChangeCarrierPopupState extends State<ChangeCarrierPopup> {
  int _selectedIndex = -1;

  @override
  void initState() {
    for (int i = 0; i < widget.carriers.length; i++) {
      if (widget.carriers[i].id == widget.currentCarrier?.id) {
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
              "Các đơn vị vận chuyển",
              style: TextStyles.mediumBlackS20,
            ),
            const SizedBox(height: 24),
            ...widget.carriers
                .asMap()
                .entries
                .map((e) => ListCarrierPopupItem(
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
                      widget.onDone?.call(widget.carriers[_selectedIndex]);
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

class ListCarrierPopupItem extends StatelessWidget {
  const ListCarrierPopupItem({
    super.key,
    this.onChanged,
    required this.selectedValue,
    required this.value,
    required this.item,
  });

  final void Function(int?)? onChanged;
  final int selectedValue;
  final int value;
  final Carrier item;

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
                    item.name,
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
                    '${item.price.formatCurrency()} đ',
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

import 'package:ecommerce_flutter/app/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../widgets/address_item.dart';
import '../widgets/address_popup.dart';

class ChangeAddressPage extends StatefulWidget {
  const ChangeAddressPage({super.key});

  @override
  State<ChangeAddressPage> createState() => _ChangeAddressPageState();
}

class _ChangeAddressPageState extends State<ChangeAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Địa chỉ của tôi",
                  style: TextStyles.mediumBlackS20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: PrimaryButton(
                    onTap: () => _showAddressPopup(context),
                    title: 'Thêm địa chỉ mới',
                    backgroundColor: AppColors.colorFFf7472f,
                    textColor: AppColors.colorFFFFFFFF,
                    textSize: 16,
                    borderColor: AppColors.colorFFf7472f,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            AddressItem(
              name: "thiệp",
              address: "Số 12 dfsfdsfsd",
              phone: "031321321321",
              onUpdate: () {},
              onSetDefault: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          alignment: Alignment.center,
          child: AddressPopup(),
        );
      },
    );
  }
}

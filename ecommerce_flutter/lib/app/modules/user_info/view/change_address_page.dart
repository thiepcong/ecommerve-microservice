import 'package:ecommerce_flutter/app/core/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/address.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';
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
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        final cubit = context.read<UserInfoCubit>();
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
                        onTap: () => _showAddressPopup(
                          context,
                          onDone: (e) => cubit.addAddress(e),
                        ),
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
                ...state.addresses
                    .asMap()
                    .entries
                    .map((e) => AddressItem(
                          item: e.value,
                          onUpdate: (value) =>
                              cubit.updateAddress(value, e.key),
                          onDelete: (value) => cubit.deleteAddress(value),
                        ))
                    .toList(),
              ],
            ),
          ),
        );
      },
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

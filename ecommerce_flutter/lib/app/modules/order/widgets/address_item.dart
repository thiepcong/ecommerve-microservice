import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/address.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import 'change_address_popup.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final cubit = context.read<OrderCubit>();
        final currentAddress = state.currentAddress;
        return Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
          decoration: const BoxDecoration(
            color: AppColors.colorFFFFFFFF,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: AppColors.colorFFf7472f,
                  ),
                  Text(
                    "Địa chỉ nhận hàng",
                    style: TextStyles.mediumMWhiteS20
                        .copyWith(color: AppColors.colorFFf7472f),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        "${currentAddress?.fname ?? ''} ${currentAddress?.lname ?? ''} ${currentAddress?.mobile ?? ''}",
                        style: TextStyles.mediumMWhiteS20
                            .copyWith(color: AppColors.colorFF000000),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "18 Ngõ 192 Phố Hạ Đình, Phường Hạ Đình, Quận Thanh Xuân, Hà Nộ",
                          style: TextStyles.regularBlackS16,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )),
                  TextButton(
                    onPressed: () => _showAddressPopup(
                      context,
                      addresses: state.addresses,
                      currentAddress: state.currentAddress,
                      onDone: (e) => cubit.setCurrentAddress(e),
                    ),
                    child: const Text("Thay đổi"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _showAddressPopup(
    BuildContext context, {
    Address? currentAddress,
    void Function(Address)? onDone,
    required List<Address> addresses,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          child: ChangeAddressPopup(
            currentAddress: currentAddress,
            onDone: onDone,
            addresses: addresses,
          ),
        );
      },
    );
  }
}

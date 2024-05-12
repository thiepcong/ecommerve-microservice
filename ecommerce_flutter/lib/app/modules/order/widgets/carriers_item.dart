import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/carrier.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../cubit/order_cubit.dart';
import '../cubit/order_state.dart';
import 'change_carrier_popup.dart';

class CarriersItem extends StatelessWidget {
  const CarriersItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final cubit = context.read<OrderCubit>();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Đơn vị vẫn chuyển:",
                    style: TextStyles.regularBlackS14,
                  ),
                  Text(
                    state.currentCarrier?.name ?? '',
                    style: TextStyles.mediumBlackS14,
                  ),
                  TextButton(
                    onPressed: () => _showAddressPopup(
                      context,
                      carriers: state.carriers,
                      currentCarrier: state.currentCarrier,
                      onDone: (e) => cubit.setCurrentCarrier(e),
                    ),
                    child: const Text("Thay đổi"),
                  ),
                  Text(
                    "${(state.currentCarrier?.price ?? 0).formatCurrency()} đ",
                    style: TextStyles.regularBlackS14
                        .copyWith(color: AppColors.colorFFf7472f),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text("Được đồng kiểm."),
                  SizedBox(width: 12),
                  Icon(Icons.help_outline),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddressPopup(
    BuildContext context, {
    Carrier? currentCarrier,
    void Function(Carrier)? onDone,
    required List<Carrier> carriers,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          child: ChangeCarrierPopup(
            currentCarrier: currentCarrier,
            onDone: onDone,
            carriers: carriers,
          ),
        );
      },
    );
  }
}

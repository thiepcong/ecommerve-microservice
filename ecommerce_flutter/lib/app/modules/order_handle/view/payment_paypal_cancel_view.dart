import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../main_router.dart';

class PaymentPaypalCancelView extends StatefulWidget {
  const PaymentPaypalCancelView({super.key});

  @override
  State<PaymentPaypalCancelView> createState() =>
      _PaymentPaypalCancelViewState();
}

class _PaymentPaypalCancelViewState extends State<PaymentPaypalCancelView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Thanh toán thất bại',
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.colorFFf7472f.withOpacity(0.9),
            borderRadius: const BorderRadius.all(Radius.circular(32)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close,
                    color: AppColors.colorFFFFFFFF,
                    size: 60,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Thanh toán thất bại",
                    style: TextStyles.boldWhiteS28,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Cùng Thiep'Shop bảo về quyền lợi của bạn!!!\nCảm ơn bạn đã sử dụng dịch vụ của Thiep'Shop",
                style: TextStyles.regularWhiteS18,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => context.router.pushAndPopUntil(
                      const HomeViewRoute(),
                      predicate: (_) => false,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorFFFFFFFF),
                      ),
                      child: const Text(
                        "Về trang chủ",
                        style: TextStyles.mediumMWhiteS20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  InkWell(
                    onTap: () => context.router.pushAndPopUntil(
                      const PurchaseViewRoute(),
                      predicate: (_) => false,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorFFFFFFFF),
                      ),
                      child: const Text(
                        "Đơn mua",
                        style: TextStyles.mediumMWhiteS20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

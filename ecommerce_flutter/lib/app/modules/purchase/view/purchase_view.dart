import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/purchase_cubit.dart';
import '../cubit/purchase_state.dart';
import '../repository/purchase_repository.dart';
import '../widgets/order_item.dart';

class PurchaseView extends StatefulWidget {
  const PurchaseView({super.key});

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Đơn mua',
      child: BlocProvider(
        create: (_) =>
            PurchaseCubit(context.read<PurchaseRepository>())..getOrderByUser(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocListener<PurchaseCubit, PurchaseState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.message != null) {
          ShowMessageInternal.showOverlay(context, state.message ?? '');
        }
      },
      child: BlocBuilder<PurchaseCubit, PurchaseState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Đơn mua',
              actions: [
                PopupMenuButton(
                  // constraints: const BoxConstraints(maxHeight: 83),
                  shape: const TooltipShape(),
                  tooltip: 'Tài khoản của bạn',
                  padding: EdgeInsets.zero,
                  offset: const Offset(0, 50),
                  color: AppColors.colorFFFFFFFF,
                  icon: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.colorFFFFFFFF,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.user != null
                            ? "${state.user!.firstName} ${state.user!.lastName}"
                            : "",
                        style: TextStyles.regularWhiteS16,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  onSelected: (value) async {
                    switch (value) {
                      case 1:
                        context.pushRoute(const UserInfoViewRoute());
                        break;
                      case 2:
                        context.router.pushAndPopUntil(
                          const PurchaseViewRoute(),
                          predicate: (_) => false,
                        );
                        break;
                      case 3:
                        context.router.pushAndPopUntil(
                          const LoginViewRoute(),
                          predicate: (_) => false,
                        );
                        break;
                      default:
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        padding: EdgeInsets.zero,
                        value: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Tài khoản của bạn"),
                        ),
                      ),
                      const PopupMenuItem(
                        padding: EdgeInsets.zero,
                        value: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Đơn mua"),
                        ),
                      ),
                      const PopupMenuItem(
                        padding: EdgeInsets.zero,
                        value: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Đăng xuất"),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg.jpg"),
                    opacity: 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    state.orders.isEmpty
                        ? const Center(
                            child: Text(
                              "Chưa có đơn mua nào",
                              style: TextStyles.mediumBlackS20,
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: state.orders
                                  .map((e) => OrderItem(item: e))
                                  .toList(),
                            ),
                          ),
                    state.isLoading
                        ? Container(
                            color: AppColors.colorFF000000.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
          );
        },
      ),
    );
  }
}

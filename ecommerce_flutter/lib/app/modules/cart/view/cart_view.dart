import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:ecommerce_flutter/app/modules/cart/widgets/bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../repository/cart_repository.dart';
import '../widgets/cart_item.dart';
import '../widgets/title_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Giỏ hàng',
      child: BlocProvider(
        create: (_) =>
            CartCubit(context.read<CartRepository>())..getAllCartItem(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.message != null) {
          ShowMessageInternal.showOverlay(context, state.message ?? '');
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final isChooseAll = state.carts.every((e) => e.isChoose);
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Giỏ hàng',
              actions: [
                PopupMenuButton(
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
                        // height: 30,
                        padding: EdgeInsets.zero,
                        value: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Tài khoản của bạn"),
                        ),
                      ),
                      const PopupMenuItem(
                        // height: 30,
                        padding: EdgeInsets.zero,
                        value: 2,
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
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TitleItem(
                          value: isChooseAll,
                          onChanged: (e) => cubit.handleChooseAll(e),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ...state.carts
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => CartItem(
                                        item: e.value,
                                        onChanged: (isChoose) =>
                                            cubit.setChooseCartItem(
                                          e.value,
                                          e.key,
                                          isChoose,
                                        ),
                                        onAdd: () =>
                                            cubit.addQuantity(e.value, e.key),
                                        onSub: () =>
                                            cubit.subQuantity(e.value, e.key),
                                        onDelete: () =>
                                            cubit.removeCartItem(e.key),
                                      ),
                                    )
                                    .toList(),
                                state.carts.isEmpty
                                    ? const Text(
                                        "Chưa có sản phẩm nào!",
                                        style: TextStyles.mediumBlackS20,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                        BottomItem(
                          value: isChooseAll,
                          onChanged: (e) => cubit.handleChooseAll(e),
                          carts: state.carts,
                          onBuy: () {
                            context.pushRoute(OrderViewRoute(
                                carts: state.carts
                                    .where((element) => element.isChoose)
                                    .toList()));
                          },
                        ),
                      ],
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
              ),
            ),
          );
        },
      ),
    );
  }
}

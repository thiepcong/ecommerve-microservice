import 'package:ecommerce_flutter/app/modules/cart/widgets/bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
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
        create: (_) => CartCubit()..init(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
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
                icon: const Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: AppColors.colorFFFFFFFF,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Thiệp",
                      style: TextStyles.regularWhiteS16,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                onSelected: (value) async {
                  switch (value) {
                    case 1:
                      break;
                    case 2:
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
                                onAdd: () => cubit.addQuantity(e.value, e.key),
                                onSub: () => cubit.subQuantity(e.value, e.key),
                                onDelete: () => cubit.removeCartItem(e.key),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ),
                BottomItem(
                  value: isChooseAll,
                  onChanged: (e) => cubit.handleChooseAll(e),
                  carts: state.carts,
                  onBuy: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

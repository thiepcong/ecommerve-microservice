import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/extension/double_extension.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';

import '../../../core/models/product.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../../../main_router.dart';
import '../../home/widgets/app_bar_home.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_detail_state.dart';
import '../repository/product_detail_repository.dart';
import '../widgets/quantity_item.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.item});

  final Product item;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Chi tiết sản phẩm',
      child: BlocProvider(
        create: (_) =>
            ProductDetailCubit(context.read<ProductDetailRepository>()),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocListener<ProductDetailCubit, ProductDetailState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.message != null) {
          ShowMessageInternal.showOverlay(context, state.message ?? '');
        }
      },
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Chi tiết sản phẩm',
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
                        AppBarHome(
                          onSearch: (e) => context.router.pushAndPopUntil(
                            const HomeViewRoute(),
                            predicate: (_) => false,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 24),
                              ImageNetwork(
                                image:
                                    "http://127.0.0.1:${widget.item.type == 'book' ? 4002 : widget.item.type == 'mobile' ? 4005 : 4006}${widget.item.image}",
                                height: 400,
                                width: 400,
                                duration: 1500,
                                curve: Curves.easeIn,
                                onPointer: true,
                                debugPrint: false,
                                fullScreen: false,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                // borderRadius: BorderRadius.circular(4),
                                onLoading: const CircularProgressIndicator(
                                  color: Colors.indigoAccent,
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.item.title,
                                      style: TextStyles.mediumBlackS42
                                          .copyWith(fontSize: 36),
                                    ),
                                    Text(
                                      "${widget.item.price.formatCurrency()} đ",
                                      style: TextStyles.mediumBlackS42.copyWith(
                                          color: AppColors.colorFFf78f2b),
                                    ),
                                    Text(
                                      "Loại: ${widget.item.type}",
                                      style: TextStyles.mediumBlackS20,
                                    ),
                                    QuantityItem(
                                      quantity: state.quantity,
                                      onAdd: () => cubit.addQuantity(),
                                      onSub: () => cubit.subQuantity(),
                                      maxQuantity: widget.item.quantity,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        CustomButton(
                                          onTap: () => cubit.addToCart(
                                              widget.item.id, widget.item.type),
                                          labelStyle: TextStyles.regularBlackS16
                                              .copyWith(
                                                  color:
                                                      AppColors.colorFFf78f2b),
                                          icon: Icons.add_shopping_cart,
                                          iconColor: AppColors.colorFFf78f2b,
                                          borderColor: AppColors.colorFFf78f2b,
                                          backgroundColor: AppColors
                                              .colorFFf78f2b
                                              .withOpacity(0.2),
                                          label: 'Thêm vào Giỏ hàng',
                                        ),
                                        const SizedBox(width: 24),
                                        CustomButton(
                                          onTap: () {},
                                          labelStyle: TextStyles.regularBlackS16
                                              .copyWith(
                                                  color:
                                                      AppColors.colorFFFFFFFF),
                                          borderColor: AppColors.colorFFf78f2b,
                                          backgroundColor:
                                              AppColors.colorFFf78f2b,
                                          label: 'Mua ngay',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                            ],
                          ),
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

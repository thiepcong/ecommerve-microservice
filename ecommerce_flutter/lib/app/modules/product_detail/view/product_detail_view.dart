import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/custom_button.dart';
import '../../home/widgets/app_bar_home.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_detail_state.dart';
import '../widgets/quantity_item.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

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
        create: (_) => ProductDetailCubit(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
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
                const AppBarHome(),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      const ImageNetwork(
                        image:
                            "https://dictionary.cambridge.org/images/thumb/butter_noun_001_02096.jpg?version=5.0.390",
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
                        onLoading: CircularProgressIndicator(
                          color: Colors.indigoAccent,
                        ),
                        onError: Icon(
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
                              "label",
                              style: TextStyles.mediumBlackS42
                                  .copyWith(fontSize: 36),
                            ),
                            Text(
                              "100.000 đ",
                              style: TextStyles.mediumBlackS42
                                  .copyWith(color: AppColors.colorFFf78f2b),
                            ),
                            const Text(
                              "Loại: Sách",
                              style: TextStyles.mediumBlackS20,
                            ),
                            QuantityItem(
                              quantity: state.quantity,
                              onAdd: () => cubit.addQuantity(),
                              onSub: () => cubit.subQuantity(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CustomButton(
                                  onTap: () {},
                                  labelStyle: TextStyles.regularBlackS16
                                      .copyWith(color: AppColors.colorFFf78f2b),
                                  icon: Icons.add_shopping_cart,
                                  iconColor: AppColors.colorFFf78f2b,
                                  borderColor: AppColors.colorFFf78f2b,
                                  backgroundColor:
                                      AppColors.colorFFf78f2b.withOpacity(0.2),
                                  label: 'Thêm vào Giỏ hàng',
                                ),
                                const SizedBox(width: 24),
                                CustomButton(
                                  onTap: () {},
                                  labelStyle: TextStyles.regularBlackS16
                                      .copyWith(color: AppColors.colorFFFFFFFF),
                                  borderColor: AppColors.colorFFf78f2b,
                                  backgroundColor: AppColors.colorFFf78f2b,
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
        );
      },
    );
  }
}

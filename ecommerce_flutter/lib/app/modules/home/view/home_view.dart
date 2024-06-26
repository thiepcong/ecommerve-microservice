import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/show_message_internal.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../repository/home_repository.dart';
import '../widgets/app_bar_home.dart';
import '../widgets/product_item.dart';
import '../widgets/tooltip_shape.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Trang chủ',
      child: BlocProvider(
        create: (_) => HomeCubit(context.read<HomeRepository>())..init(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final products = state.products
              .where((element) =>
                  state.filter == null || element.type == state.filter)
              .toList();
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Trang chủ',
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
                  Column(
                    children: [
                      AppBarHome(onSearch: (e) => cubit.search(e)),
                      // Expanded(child: Size)
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: PrimaryButton(
                                onTap: () => cubit.setFilter('book'),
                                title: "Book",
                                backgroundColor: state.filter == 'book'
                                    ? AppColors.colorFFf7472f
                                    : AppColors.transparent,
                                textColor: state.filter == 'book'
                                    ? AppColors.colorFFFFFFFF
                                    : AppColors.colorFFf7472f,
                                borderColor: AppColors.colorFFf7472f,
                                textSize: 24,
                              ),
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: PrimaryButton(
                                onTap: () => cubit.setFilter('mobile'),
                                title: "Mobile",
                                backgroundColor: state.filter == 'mobile'
                                    ? AppColors.colorFFf7472f
                                    : AppColors.transparent,
                                textColor: state.filter == 'mobile'
                                    ? AppColors.colorFFFFFFFF
                                    : AppColors.colorFFf7472f,
                                borderColor: AppColors.colorFFf7472f,
                                textSize: 24,
                              ),
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: PrimaryButton(
                                onTap: () => cubit.setFilter('clothes'),
                                title: "Clothes",
                                backgroundColor: state.filter == 'clothes'
                                    ? AppColors.colorFFf7472f
                                    : AppColors.transparent,
                                textColor: state.filter == 'clothes'
                                    ? AppColors.colorFFFFFFFF
                                    : AppColors.colorFFf7472f,
                                borderColor: AppColors.colorFFf7472f,
                                textSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: products.isEmpty
                            ? const Center(
                                child: Text(
                                  "Không có sản phẩm nào",
                                  style: TextStyles.mediumBlackS20,
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 32),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return ProductItem(item: products[index]);
                                },
                              ),
                      ),
                    ],
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

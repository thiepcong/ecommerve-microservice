import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/show_message_internal.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
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
        create: (_) => HomeCubit(),
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
                  // Expanded(child: Size)
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 32),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 18,
                      itemBuilder: (context, index) {
                        return const ProductItem();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

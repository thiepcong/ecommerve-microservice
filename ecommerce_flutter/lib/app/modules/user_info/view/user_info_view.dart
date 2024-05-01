import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../../home/widgets/app_bar_home.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';
import '../repository/user_info_repository.dart';
import 'change_address_page.dart';
import 'change_password_page.dart';
import 'update_profile_page.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Tài khoản của bạn',
      child: BlocProvider(
        create: (_) =>
            UserInfoCubit(context.read<UserInfoRepository>())..init(),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserInfoCubit, UserInfoState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message ?? '');
            }
          },
        ),
      ],
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          final cubit = context.read<UserInfoCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              label: 'Tài khoản của bạn',
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
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 24),
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.colorFFFFFFFF,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () => cubit.setFilter(0),
                                        child: Text(
                                          "Hồ sơ",
                                          style: TextStyles.mediumBlackS20
                                              .copyWith(
                                                  color: state.filter == 0
                                                      ? AppColors.colorFFf7472f
                                                      : null),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => cubit.setFilter(1),
                                        child: Text(
                                          "Địa chỉ",
                                          style: TextStyles.mediumBlackS20
                                              .copyWith(
                                                  color: state.filter == 1
                                                      ? AppColors.colorFFf7472f
                                                      : null),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => cubit.setFilter(2),
                                        child: Text(
                                          "Đổi mật khẩu",
                                          style: TextStyles.mediumBlackS20
                                              .copyWith(
                                                  color: state.filter == 2
                                                      ? AppColors.colorFFf7472f
                                                      : null),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: state.filter == 0
                                      ? const UpdateProfilePage()
                                      : state.filter == 1
                                          ? const ChangeAddressPage()
                                          : const ChangePasswordPage(),
                                ),
                              ],
                            ),
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

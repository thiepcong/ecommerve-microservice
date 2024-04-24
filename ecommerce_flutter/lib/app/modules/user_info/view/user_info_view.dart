import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/core/values/show_message_internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../../../main_router.dart';
import '../../home/widgets/app_bar_home.dart';
import '../../home/widgets/tooltip_shape.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';
import '../repository/user_info_repository.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
        BlocListener<UserInfoCubit, UserInfoState>(
          listenWhen: (previous, current) => previous.user != current.user,
          listener: (context, state) {
            _emailController.text = state.user?.email ?? '';
            _firstNameController.text = state.user?.firstName ?? "";
            _lastNameController.text = state.user?.lastName ?? '';
            _phoneController.text = state.user?.phoneNumber ?? '';
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 240, vertical: 24),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.colorFFFFFFFF,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hồ sơ của bạn",
                                      style: TextStyles.mediumBlackS20,
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _firstNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Họ',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Vui lòng nhập họ của bạn!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Tên',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Vui lòng nhập tên người dùng!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _phoneController,
                                        decoration: const InputDecoration(
                                          labelText: 'Số điện thoại',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Vui lòng nhập tên người dùng!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _emailController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Vui lòng nhập mật khẩu!';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    PrimaryButton(
                                      onTap: () => cubit.changeInfo(
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _phoneController.text,
                                      ),
                                      title: 'Lưu thay đổi',
                                      backgroundColor: AppColors.colorFFf7472f,
                                      textColor: AppColors.colorFFFFFFFF,
                                      textSize: 32,
                                      borderColor: AppColors.colorFFf7472f,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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

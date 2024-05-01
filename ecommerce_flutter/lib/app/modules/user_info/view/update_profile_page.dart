import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
    return BlocListener<UserInfoCubit, UserInfoState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        _emailController.text = state.user?.email ?? '';
        _firstNameController.text = state.user?.firstName ?? "";
        _lastNameController.text = state.user?.lastName ?? '';
        _phoneController.text = state.user?.phoneNumber ?? '';
      },
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          final cubit = context.read<UserInfoCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
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
                          if (value == null || value.trim().isEmpty) {
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
                          if (value == null || value.trim().isEmpty) {
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
                          if (value == null || value.trim().isEmpty) {
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
                          if (value == null || value.trim().isEmpty) {
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
          );
        },
      ),
    );
  }
}

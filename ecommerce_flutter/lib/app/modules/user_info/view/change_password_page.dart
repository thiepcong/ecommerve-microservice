import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/button/primary_button.dart';
import '../cubit/user_info_cubit.dart';
import '../cubit/user_info_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
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
                    "Thay đổi mật khẩu",
                    style: TextStyles.mediumBlackS20,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _oldController,
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu cũ',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập mật khẩu cũ của bạn!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _newController,
                      decoration: const InputDecoration(
                        labelText: 'Mật khẩu mới',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập mật khẩu mới của bạn!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    onTap: () => cubit.changePassword(
                      _oldController.text,
                      _newController.text,
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
    );
  }
}

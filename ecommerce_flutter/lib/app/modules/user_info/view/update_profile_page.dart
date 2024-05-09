import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _showSelectDate(
    BuildContext context,
    void Function(DateTime) onPicker,
  ) async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (res != null) {
      onPicker.call(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserInfoCubit, UserInfoState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        _addressController.text = state.user?.address ?? '';
        _firstNameController.text = state.user?.firstName ?? "";
        _lastNameController.text = state.user?.lastName ?? '';
        _phoneController.text = state.user?.mobile ?? '';
        _dobController.text =
            DateFormat('dd/MM/yyyy').format(state.user?.dob ?? DateTime.now());
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
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Địa chỉ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập địa chỉ!';
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () => _showSelectDate(context, (date) {
                              _dobController.text =
                                  DateFormat("dd/MM/yyyy").format(date);
                            }),
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập ngày sinh!';
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
                        _addressController.text,
                        DateFormat('dd/MM/yyyy').parse(_dobController.text),
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

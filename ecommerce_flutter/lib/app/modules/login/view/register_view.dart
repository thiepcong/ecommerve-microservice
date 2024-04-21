import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/show_message_internal.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/appBar/custom_app_bar.dart';
import '../../../main_router.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../repository/login_repository.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: AppColors.colorFFFFFFFF,
      title: 'Đăng ký',
      child: BlocProvider(
        create: (_) => LoginCubit(context.read<LoginRepository>()),
        child: _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.authDone != current.authDone,
          listener: (context, state) {
            if (state.authDone) {
              context.pushRoute(const HomeViewRoute());
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              ShowMessageInternal.showOverlay(context, state.message!);
            }
          },
        ),
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          return Scaffold(
            appBar: const CustomAppBar(
              label: 'ECOMMERCE',
              isLeading: false,
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
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      width: 400,
                      height: 500,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Đăng ký",
                                style: TextStyles.boldBlackS28,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tên',
                                    border: OutlineInputBorder(),
                                  ),
                                  onFieldSubmitted: (e) {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.register(
                                          _nameController.text,
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Vui lòng nhập tên của bạn!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Tên người dùng',
                                    border: OutlineInputBorder(),
                                  ),
                                  onFieldSubmitted: (e) {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.register(
                                          _nameController.text,
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  },
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
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Mật khẩu',
                                    border: OutlineInputBorder(),
                                  ),
                                  onFieldSubmitted: (e) {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.register(
                                          _nameController.text,
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Vui lòng nhập lại mật khẩu!';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _passwordAgainController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập lại mật khẩu',
                                    border: OutlineInputBorder(),
                                  ),
                                  onFieldSubmitted: (e) {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.register(
                                          _nameController.text,
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Vui lòng nhập mật khẩu!';
                                    }
                                    if (value !=
                                        _passwordAgainController.text) {
                                      return 'Mật khẩu không trùng khớp';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.register(
                                        _nameController.text,
                                        _usernameController.text,
                                        _passwordController.text);
                                  }
                                },
                                child: const Text('Register'),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Đã có tài khoản?"),
                                  TextButton(
                                    onPressed: () => context.router
                                        .replace(const LoginViewRoute()),
                                    child: const Text("Đăng nhập"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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

import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/string_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/bloc/auth_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/widgets/fingerprint_button.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/image_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormGlobalKey = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  var loginEmail = TextEditingController(text: "user@example.com");
  var loginPassword = TextEditingController(text: "haonek2003");

  @override
  void dispose() {
    loginFormGlobalKey.currentState?.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    loginEmail.dispose();
    loginPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: "Đăng nhập",
        isShowBack: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: loginFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              const ImageLogo(),
              // Text file Email
              TextFormField(
                focusNode: _emailFocusNode,
                controller: loginEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: AppTextStyles.regular14,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Nhập Email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                validator: (value) =>
                    (value!.isEmail) ? null : 'Invalid email address',
                onTapOutside: (event) {
                  _emailFocusNode.unfocus();
                },
                onFieldSubmitted: (_) {
                  // chuyen qua textfill tiep theo
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              const SizedBox(height: 15),
              // text field password
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: loginPassword,
                    obscureText: state.isShowPassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        hintText: 'Nhập mật khẩu',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !state.isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.green,
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(TogglePasswordVisibility());
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Làm ơn nhập mật khẩu',
                    onTapOutside: (event) {
                      _passwordFocusNode.unfocus();
                    },
                  );
                },
              ),

              // quen mat khau
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.fogot);
                      },
                      child: const Text('Quên mật khẩu?')),
                ],
              ),

              // button login
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  void onLogin() {
                    if (loginFormGlobalKey.currentState!.validate()) {
                      context
                          .read<AuthBloc>()
                          .add(AuthLogin(loginEmail.text, loginPassword.text));

                      if (state.status == AuthStatus.success) {
                        if (!context.mounted) return;
                        context.snackBar('Đăng nhập thành công!');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.bottomBar,
                          (Route<dynamic> route) => false,
                        );
                      } else if (state.status == AuthStatus.failure) {
                        if (!context.mounted) return;
                        context.snackBar(state.failureMessage,
                            type: AnimatedSnackBarType.error);
                      }
                    }
                  }

                  return SizedBox(
                    width: 100.wp,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : onLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                              elevation: 10,
                              minimumSize: Size(100.wp, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Đăng nhập',
                              style:
                                  AppTextStyles.bold14.colorEx(AppColors.white),
                            ),
                          ),
                        ),
                        FingerprintButton(),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản? "),
                  TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed(AppRoutes.register);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                      ),
                      child: const Text('Đăng ký ngay')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

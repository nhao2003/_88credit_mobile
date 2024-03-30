import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/extensions/string_ex.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/image_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerFormGlobalKey = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();

  var registerEmail = TextEditingController();
  var registerPassword = TextEditingController();
  var registerRepeatPassword = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    registerEmail.dispose();
    registerPassword.dispose();
    registerRepeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Đăng ký"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: registerFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              const ImageLogo(),
              // text field email
              TextFormField(
                focusNode: _emailFocusNode,
                controller: registerEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                style: AppTextStyles.regular14,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Nhập Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) =>
                    (value!.isEmail) ? null : 'Email không hợp lệ',
                onTapOutside: (event) {
                  _emailFocusNode.unfocus();
                },
                onFieldSubmitted: (_) {
                  // chuyen qua textfill tiep theo
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: registerPassword,
                    obscureText: state.isShowPassword,
                    style: AppTextStyles.regular14,
                    autocorrect: false,
                    enableSuggestions: false,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        labelText: 'Nhập mật khẩu',
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mật khẩu không được để trống';
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _passwordFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_rePasswordFocusNode);
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _rePasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: registerRepeatPassword,
                    obscureText: state.isShowComfirmPassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        hintText: 'Nhập lại mật khẩu',
                        labelText: 'Nhập lại mật khẩu',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !state.isShowComfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.green,
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(ToggleConfirmPasswordVisibility());
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mật khẩu không được để trống';
                      } else if (value != registerRepeatPassword.text) {
                        return "Mật khẩu không khớp";
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _rePasswordFocusNode.unfocus();
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              // Button register
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(color: AppColors.white),
                  elevation: 10,
                  minimumSize: Size(100.wp, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Đăng ký',
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Đã có tài khoản? "),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.login);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    child: const Text('Đăng nhập'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

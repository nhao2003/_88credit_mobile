import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/auth_bloc.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _newpassFocusNode = FocusNode();
  final _reNewpassFocusNode = FocusNode();

  var newPasswordTextController = TextEditingController();
  var reNewPasswordTextController = TextEditingController();

  @override
  void dispose() {
    _newpassFocusNode.dispose();
    _reNewpassFocusNode.dispose();
    newPasswordTextController.dispose();
    reNewPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Quên mật khẩu"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.forgotPassword,
                    width: 70.wp,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "NHAGIARE",
                    style: AppTextStyles.semiBold20.colorEx(AppColors.green),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Nhập mật khẩu mới",
                    style: AppTextStyles.regular14.colorEx(AppColors.grey700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),
// text feild new password
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _newpassFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: newPasswordTextController,
                    obscureText: state.isShowPassword,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        labelText: 'Mật khẩu mới',
                        hintText: 'Nhập mật khẩu mới',
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
                            context.read<AuthBloc>().add(
                                  TogglePasswordVisibility(),
                                );
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) => (!(value == null || value == ''))
                        ? null
                        : 'Làm ơn nhập mật khẩu',
                    onTapOutside: (event) {
                      _newpassFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_reNewpassFocusNode);
                    },
                  );
                },
              ),
// text feild repeat password
              const SizedBox(height: 15),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _reNewpassFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: reNewPasswordTextController,
                    obscureText: state.isShowComfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu mới',
                        hintText: 'Nhập lại mật khẩu mới',
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
                            context.read<AuthBloc>().add(
                                  ToggleConfirmPasswordVisibility(),
                                );
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value != newPasswordTextController.text) {
                        return "Mật khẩu không khớp";
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _reNewpassFocusNode.unfocus();
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              // button tiep tuc
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(color: AppColors.white),
                  minimumSize: Size(100.wp, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  'Cập nhập lại mật khẩu',
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

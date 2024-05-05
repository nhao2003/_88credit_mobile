import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/string_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/opt_bottom_sheet.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailFocusNode = FocusNode();

  var emailForgotTextController = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    emailForgotTextController.dispose();
    super.dispose();
  }

  void _showOTPBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return OTPBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: "Quên mật khẩu"),
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
                    "Vui lòng điền email gắn với tài khoản của bạn để nhận đường dẫn thay đổi mật khẩu",
                    style: AppTextStyles.regular14.colorEx(AppColors.grey700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return TextFormField(
                    focusNode: _emailFocusNode,
                    controller: emailForgotTextController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    style: AppTextStyles.regular14,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Nhập Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) =>
                        (value!.isEmail) ? null : 'Email không hợp lệ',
                    onTapOutside: (event) {
                      _emailFocusNode.unfocus();
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              // button tiep tuc
              ElevatedButton(
                onPressed: () {
                  _showOTPBottomSheet(context);
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
                  'Tiếp tục',
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
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
                    child: const Text('Đăng ký ngay'),
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

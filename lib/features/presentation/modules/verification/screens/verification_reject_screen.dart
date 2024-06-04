import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';

class VerificationRejectScreen extends StatelessWidget {
  const VerificationRejectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reason = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Yêu cầu bị từ chối"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Lottie.asset(
                Assets.cardReject,
              ),
            ),
            Text(
              "Tài khoản của bạn không được xác minh vì lý do $reason",
              textAlign: TextAlign.center,
              style: AppTextStyles.bold18,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.verificationCard);
          },
          child: Center(
            child: Text(
              "Định danh lại tài khoản",
              style: AppTextStyles.bold16,
            ),
          ),
        ),
      ),
    );
  }
}

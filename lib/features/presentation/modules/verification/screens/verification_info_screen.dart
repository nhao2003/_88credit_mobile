import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/verification_bloc.dart';
import '../widgets/form_informations.dart';
import '../widgets/stepper_identify.dart';

class VerificationInfoScreen extends StatelessWidget {
  const VerificationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Nhập thông tin cá nhân"),
      ),
      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // container steps
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                children: [
                  Text(
                    "Thông tin của bạn đã được mã hóa và bảo đảm an toàn theo quy định của pháp luật.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold14,
                  ),
                  const SizedBox(height: 10),
                  const StepperIdentify(2),
                ],
              ),
            ),
            // form register
            const FormInfomations(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocBuilder<VerificationBloc, VerificationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed:
                        state.uploadInfoStatus != UploadInfoStatus.loading
                            ? () {
                                // finishVerification();
                              }
                            : null,
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
                      'Hoàn tất',
                      style: AppTextStyles.bold14.colorEx(AppColors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

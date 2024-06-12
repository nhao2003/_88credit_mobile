import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/verification_bloc.dart';
import '../widgets/change_type_doc.dart';
import '../widgets/choose_image.dart';
import '../widgets/stepper_identify.dart';

class VerificationCardScreen extends StatefulWidget {
  const VerificationCardScreen({super.key});

  @override
  State<VerificationCardScreen> createState() => _VerificationCardScreenState();
}

class _VerificationCardScreenState extends State<VerificationCardScreen> {
  @override
  void initState() {
    context.read<VerificationBloc>().add(InitEkycEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Chụp ảnh giấy tờ tùy thân"),
      ),
      // body
      body: BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          if (state.initEkycStatus == InitEkycStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
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
                      "Vui lòng gửi hình ảnh giấy tờ còn hạn, hình gốc không scan hay photocopy.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bold14,
                    ),
                    const SizedBox(height: 10),
                    const StepperIdentify(0),
                  ],
                ),
              ),
              // change type identity documents
              const ChangeTypeDoc(),
              // text chup 2 mat
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Text(
                      "Chụp 2 mặt của giấy tờ",
                      style: AppTextStyles.bold14,
                    ),
                  ],
                ),
              ),
              // 2 image
              const Row(
                children: [
                  ChooseImage(true), // mặt trước
                  ChooseImage(false), // mặt sau
                ],
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: BlocBuilder<VerificationBloc, VerificationState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed:
                          state.uploadCardStatus != UploadCardStatus.loading
                              ? () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.verificationPortrait);
                                  context
                                      .read<VerificationBloc>()
                                      .add(const ChangeStepEvent(1));
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
                        'Tiếp tục',
                        style: AppTextStyles.bold14.colorEx(AppColors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

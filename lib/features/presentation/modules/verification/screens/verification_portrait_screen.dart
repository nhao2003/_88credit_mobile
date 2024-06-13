import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/verification_bloc.dart';
import '../widgets/choose_image_portrait.dart';
import '../widgets/stepper_identify.dart';

class VerificationPortraitScreen extends StatefulWidget {
  const VerificationPortraitScreen({super.key});

  @override
  State<VerificationPortraitScreen> createState() =>
      _VerificationPortraitScreenState();
}

class _VerificationPortraitScreenState
    extends State<VerificationPortraitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Chụp ảnh chân dung"),
      ),
      // body
      body: Column(
        children: [
// container steps
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Vui lòng cung cấp cho chúng tôi hình ảnh thật chân dung của bạn.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold14,
                ),
                const SizedBox(height: 10),
                const StepperIdentify(1),
              ],
            ),
          ),
// change type identity documents
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: double.infinity,
            child: const ChooseImagePortrait(),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                if (state.submtiStatus == SubmtiStatus.success) {
                  context.snackBar("Xác minh thành công");
                } else if (state.submtiStatus == SubmtiStatus.failure) {
                  context.snackBar(state.failureMessage,
                      type: SnackBarType.error);
                }

                return ElevatedButton(
                  onPressed:
                      state.uploadPortraitstatus != UploadPortraitstatus.success
                          ? null
                          : state.submtiStatus == SubmtiStatus.success
                              ? () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.verificationInfo);
                                  context
                                      .read<VerificationBloc>()
                                      .add(const ChangeStepEvent(2));
                                }
                              : state.submtiStatus == SubmtiStatus.loading
                                  ? null
                                  : () {
                                      context
                                          .read<VerificationBloc>()
                                          .add(SubmitEkyc());
                                    },
                  // return ElevatedButton(
                  //   onPressed:
                  //       state.uploadPortraitstatus == UploadPortraitstatus.success
                  //           ? () {
                  //               Navigator.pushNamed(
                  //                   context, AppRoutes.verificationInfo);
                  //               context
                  //                   .read<VerificationBloc>()
                  //                   .add(const ChangeStepEvent(2));
                  //             }
                  //           : null,
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
                    state.submtiStatus == SubmtiStatus.success
                        ? 'Tiếp tục'
                        : 'Kiểm tra ảnh chân dung',
                    style: AppTextStyles.bold14.colorEx(AppColors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

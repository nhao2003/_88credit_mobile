import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../globalwidgets/base_card.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/create_post_bloc.dart';
import '../widgets/borrowing_form.dart';
import '../widgets/choose_lending_card.dart';
import '../widgets/lending_form.dart';
import '../widgets/post_info_card.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final infoFormKey = GlobalKey<FormState>();
  final borrowingFormKey = GlobalKey<FormState>();
  final lendingFormKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final borrowingLoanAmountTextController = TextEditingController();
  final borrowingInterestRateTextController = TextEditingController();
  final borrowingOverdueInterestRateTextController = TextEditingController();
  final borrowingTenureMonthsTextController = TextEditingController();
  final borrowingLoanReasonTextController = TextEditingController();

  final lendingLoanAmountTextController = TextEditingController();
  final lendingMaxLoanAmountTextController = TextEditingController();
  final lendingInterestRateTextController = TextEditingController();
  final lendingMaxInterestRateTextController = TextEditingController();
  final lendingTenureMonthsTextController = TextEditingController();
  final lendingMaxTenureMonthsTextController = TextEditingController();
  final lendingOverdueInterestRateTextController = TextEditingController();
  final lendingMaxOverdueInterestRateTextController = TextEditingController();

  bool validatorForm(bool isLending) {
    bool isValidate = true;
    isValidate = isValidate & infoFormKey.currentState!.validate();
    if (isLending) {
      isValidate = isValidate & lendingFormKey.currentState!.validate();
    } else {
      isValidate = isValidate & borrowingFormKey.currentState!.validate();
    }
    return isValidate;
  }

  PostEntity createPost(
      bool isLending, LoanReasonTypes loanReasonType, List<String>? images) {
    try {
      if (isLending) {
        // Lending
        return PostEntity(
          isLease: isLending,
          title: titleTextController.text,
          description: descriptionTextController.text,
          images: images,
          amount: double.tryParse(lendingLoanAmountTextController.text),
          maxAmount: double.tryParse(lendingMaxLoanAmountTextController.text),
          interestRate: double.tryParse(lendingInterestRateTextController.text),
          maxInterestRate:
              double.tryParse(lendingMaxInterestRateTextController.text),
          duration: int.tryParse(lendingTenureMonthsTextController.text),
          maxDuration: int.tryParse(lendingMaxTenureMonthsTextController.text),
          overdueInterestRate:
              double.tryParse(lendingOverdueInterestRateTextController.text),
          maxOverdueInterestRate:
              double.tryParse(lendingMaxOverdueInterestRateTextController.text),
        );
      } else {
        return PostEntity(
          isLease: isLending,
          title: titleTextController.text,
          description: descriptionTextController.text,
          images: images,
          amount: double.tryParse(borrowingLoanAmountTextController.text),
          interestRate:
              double.tryParse(borrowingInterestRateTextController.text),
          duration: int.tryParse(borrowingTenureMonthsTextController.text),
          loanReason: loanReasonType,
          loanReasonDescription: borrowingLoanReasonTextController.text,
        );
      }
    } catch (e) {
      print("Error when Create Post: $e");
      return const PostEntity();
    }
  }

  void uploadPost(BuildContext context, CreatePostState state) {
    // check validate
    if (!validatorForm(state.isLending)) {
      return context.snackBar(
        'Vui lòng điền đầy đủ thông tin bắt buộc!',
        type: SnackBarType.error,
      );
    }

    // upload images
    context.read<CreatePostBloc>().add(
          UploadImagesEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: 'Đăng tin',
      ),
      body: ListView(
        children: [
          BlocBuilder<CreatePostBloc, CreatePostState>(
            builder: (context, state) {
              // đăng bài
              if (state.uploadImagesStatus == UploadImagesStatus.failure) {
                context.snackBar(
                  'Có lỗi xảy ra khi tải ảnh lên!',
                  type: SnackBarType.error,
                );
              } else if (state.uploadImagesStatus ==
                  UploadImagesStatus.success) {
                final post = createPost(
                  state.isLending,
                  state.loanReasonType,
                  state.imageUrlList,
                );
                context.read<CreatePostBloc>().add(
                      SendPostEvent(post),
                    );
              }
              
              if (state.status == CreatePostStatus.success) {
                context.snackBar(
                  'Đăng bài thành công!',
                  type: SnackBarType.success,
                );
              } else if (state.status == CreatePostStatus.failure) {
                context.snackBar(
                  'Có lỗi xảy ra khi đăng bài!',
                  type: SnackBarType.error,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // choose is lease
                  const BaseCard(
                    title: "Loại bài đăng",
                    isvisible: true,
                    child: ChooseLendingCard(),
                  ),
                  // Thong tin bai dang
                  BaseCard(
                    title: "Thông tin bài đăng",
                    isvisible: true,
                    child: PostInfoCard(
                      infoFormKey: infoFormKey,
                      titleTextController: titleTextController,
                      descriptionTextController: descriptionTextController,
                    ),
                  ),
                  BorrowingForm(
                    isvisible: !state.isLending,
                    borrowingFormKey: borrowingFormKey,
                    borrowingLoanAmountTextController:
                        borrowingLoanAmountTextController,
                    borrowingInterestRateTextController:
                        borrowingInterestRateTextController,
                    borrowingOverdueInterestRateTextController:
                        borrowingOverdueInterestRateTextController,
                    borrowingTenureMonthsTextController:
                        borrowingTenureMonthsTextController,
                    borrowingLoanReasonTextController:
                        borrowingLoanReasonTextController,
                  ),
                  LendingForm(
                    isvisible: state.isLending,
                    lendingFormKey: lendingFormKey,
                    lendingLoanAmountTextController:
                        lendingLoanAmountTextController,
                    lendingMaxLoanAmountTextController:
                        lendingMaxLoanAmountTextController,
                    lendingInterestRateTextController:
                        lendingInterestRateTextController,
                    lendingMaxInterestRateTextController:
                        lendingMaxInterestRateTextController,
                    lendingTenureMonthsTextController:
                        lendingTenureMonthsTextController,
                    lendingMaxTenureMonthsTextController:
                        lendingMaxTenureMonthsTextController,
                    lendingOverdueInterestRateTextController:
                        lendingOverdueInterestRateTextController,
                    lendingMaxOverdueInterestRateTextController:
                        lendingMaxOverdueInterestRateTextController,
                  ),
                  // dang bai ============================================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: state.status == CreatePostStatus.loading
                          ? null
                          : () {},
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
                      child: state.status == CreatePostStatus.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Đăng bài',
                              style:
                                  AppTextStyles.bold14.colorEx(AppColors.white),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

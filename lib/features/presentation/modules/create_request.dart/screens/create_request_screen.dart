import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/user.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../../request_detail.dart/widgets/credit_card.dart';
import '../../request_detail.dart/widgets/user_card.dart';
import '../bloc/create_request_bloc.dart';
import '../widgets/images_form.dart';
import '../widgets/loan_info_form.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  // create Request
  final requestFormKey = GlobalKey<FormState>();

  final loanAmountTextController = TextEditingController();
  final interestRateTextController = TextEditingController();
  final overdueInterestRateTextController = TextEditingController();
  final tenureMonthsTextController = TextEditingController();
  final loanReasonTextController = TextEditingController();
  final discriptionTextController = TextEditingController();

  @override
  void dispose() {
    loanAmountTextController.dispose();
    interestRateTextController.dispose();
    overdueInterestRateTextController.dispose();
    tenureMonthsTextController.dispose();
    loanReasonTextController.dispose();
    discriptionTextController.dispose();
    super.dispose();
  }

  bool validatorForm() {
    return requestFormKey.currentState!.validate();
  }

  void uploadRequest(BuildContext context, CreateRequestState state) {
    if (!validatorForm()) {
      return context.snackBar(
        'Vui lòng điền đầy đủ thông tin bắt buộc!',
        type: SnackBarType.error,
      );
    }

    if (state.portrait == null ||
        state.idCardFrontPhoto == null ||
        state.idCardBackPhoto == null ||
        state.video == null) {
      return context.snackBar(
        'Vui lòng cung cấp ảnh và video!',
        type: SnackBarType.error,
      );
    }

    context.read<CreateRequestBloc>().add(
          SendRequestEvent(
            description: discriptionTextController.text,
            loanAmount: double.tryParse(loanAmountTextController.text),
            interestRate: double.tryParse(interestRateTextController.text),
            overdueInterestRate:
                double.tryParse(overdueInterestRateTextController.text),
            loanTenureMonths: int.tryParse(tenureMonthsTextController.text),
            loanReason: loanReasonTextController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      context.read<CreateRequestBloc>().add(
            ChangeReceiver(
                ModalRoute.of(context)!.settings.arguments as UserEntity),
          );
    }
    return Scaffold(
      appBar: const MyAppbar(title: "Tạo yêu cầu vay"),
      body: ListView(
        children: [
          BlocBuilder<CreateRequestBloc, CreateRequestState>(
              builder: (context, state) {
            return Form(
              key: requestFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: UserCard(
                      title: "Người cho vay",
                      name: state.receiver.fullName,
                      avatar: state.receiver.avatar,
                      buttonText: "Thay đổi",
                      navToProfile: () {
                        Navigator.of(context).pushNamed(AppRoutes.changeUser);
                      },
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: state.getPrimaryBankCardStatus ==
                            GetPrimaryBankCardStatus.loading
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                  strokeWidth: 2,
                                ),
                              ),
                            ))
                        : state.getPrimaryBankCardStatus ==
                                    GetPrimaryBankCardStatus.failure ||
                                state.primaryBankCard.cardNumber == null
                            ? CreditCard(
                                bankName: "Chọn thẻ",
                                bankNumber: "Không có dữ liệu",
                                hanleChooseCard: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.bank);
                                },
                                buttonText: "Chọn thẻ",
                              )
                            : CreditCard(
                                bankName: state.primaryBankCard.bank!.shortName,
                                bankNumber: state.primaryBankCard.cardNumber!,
                                logoBank: state.primaryBankCard.bank!.logo,
                                hanleChooseCard: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.bank)
                                      .then((value) => context
                                          .read<CreateRequestBloc>()
                                          .add(const GetPrimaryBankCard()));
                                },
                                buttonText: "Đổi thẻ",
                              ),
                  ),
                  // Thong tin bai dang
                  LoanInfoForm(
                    isvisible: true,
                    discriptionTextController: discriptionTextController,
                    loanAmountTextController: loanAmountTextController,
                    interestRateTextController: interestRateTextController,
                    loanReasonTextController: loanReasonTextController,
                    overdueInterestRateTextController:
                        overdueInterestRateTextController,
                    tenureMonthsTextController: tenureMonthsTextController,
                  ),
                  // images
                  ImagesForm(
                    isvisible: true,
                  ),
                  // dang bai ============================================
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: state.createRequestStatus ==
                              CreateRequestStatus.loading
                          ? null
                          : () {
                              uploadRequest(context, state);
                            },
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
                      child: state.createRequestStatus ==
                              CreateRequestStatus.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Tạo yêu cầu',
                              style:
                                  AppTextStyles.bold14.colorEx(AppColors.white),
                            ),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

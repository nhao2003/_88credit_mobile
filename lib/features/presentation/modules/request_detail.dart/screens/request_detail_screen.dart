import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/utils/add_months_date.dart';
import '../../../../../core/utils/bank_format.dart';
import '../../../../domain/entities/loan_request.dart';
import '../../../../domain/enums/loan_contract_request_status.dart';
import '../../../globalwidgets/base_button.dart';
import '../../../globalwidgets/header_title.dart';
import '../../../globalwidgets/image_card.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../../post_detail/widgets/description_card.dart';
import '../bloc/request_detail_bloc.dart';
import '../widgets/credit_card.dart';
import '../widgets/dialog_cancel.dart';
import '../widgets/loan_amount_card.dart';
import '../widgets/more_request_info_card.dart';
import '../widgets/received_amount_item.dart';
import '../widgets/user_card.dart';
import '../widgets/video_card.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  LoanRequestEntity post = const LoanRequestEntity();

  void showCommentForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DialogCancel(
          request: post,
          handleRejectRequest: (LoanRequestEntity request,
              String reason) {} // controller.rejectRequest,
          ),
    );
  }

  void copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    context.snackBar(
      "Đã sao chép",
    );
  }

  @override
  Widget build(BuildContext context) {
    post = ModalRoute.of(context)!.settings.arguments as LoanRequestEntity;
    print(post.status!);
    context.read<RequestDetailBloc>().add(ChangeRequestStatus(post.status!));

    return Scaffold(
      appBar: MyAppbar(
        title: "Chi tiết yêu cầu",
        actions: [
          TextButton(
            onPressed: () {
              // controller.reviewContract(post);
            },
            child: Text(
              "Xem hợp đồng",
              style: AppTextStyles.regular12.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.green,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ReceivedAmountItem(
              moneyRequest: post.loanAmount!,
            ),
            const SizedBox(height: 20),
            LoanAmountCard(
              loanAmount: post.loanAmount!,
              interestAmount: 50000,
              serviceCharge: 10000,
            ),
            const SizedBox(height: 20),
            MoreRequestInfo(
              loanTenureMonths: post.loanTenureMonths!,
              interestRate: post.interestRate!,
              overdueInterestRate: post.overdueInterestRate!,
              loanReasonType: post.loanReasonType!,
              dateLoan: post.createdAt!,
              datePay: AddMonthDate.addMonthsToDateTime(
                  post.createdAt!, post.loanTenureMonths!),
            ),
            const SizedBox(height: 20),
            UserCard(
                title: "Người gửi",
                name: post.sender!.fullName,
                avatar: post.sender!.avatar!,
                navToProfile: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.userProfile, arguments: post.sender);
                }),
            const SizedBox(height: 20),
            CreditCard(
              bankName: post.senderBankCard!.bank!.shortName,
              bankNumber:
                  BankFormat.formatCardNumber(post.senderBankCard!.cardNumber!),
              logoBank: post.senderBankCard!.bank!.logo,
              hanleChooseCard: () {
                copyToClipboard(post.senderBankCard!.cardNumber!, context);
              },
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Mô tả yêu cầu",
              description: post.description!,
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Mô tả lý do vay",
              description: post.loanReason!,
            ),
            const SizedBox(height: 20),
            if (post.status == LoanContractRequestStatus.rejected &&
                post.rejectedReason != null)
              DescriptionCard(
                title: "Lý do hủy yêu cầu",
                description: post.rejectedReason!,
              ),
            const SizedBox(height: 10),
            const HeaderTitle(title: "Ảnh chân dung"),
            const SizedBox(height: 10),
            ImageCard(images: [post.portaitPhoto!]),
            const SizedBox(height: 10),
            const HeaderTitle(title: "Ảnh căn cước / CMND:"),
            const SizedBox(height: 10),
            ImageCard(images: [post.idCardFrontPhoto!, post.idCardBackPhoto!]),
            if (post.videoConfirmation != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  const HeaderTitle(title: "Video minh chứng:"),
                  const SizedBox(height: 10),
                  VideoCard(videoUrl: post.videoConfirmation!),
                ],
              ),
            const SizedBox(height: 20),

            // Button
            BlocBuilder<RequestDetailBloc, RequestDetailState>(
              builder: (context, state) {
                if (state.confirmStatus == ConfirmStatus.loading ||
                    state.rejectStatus == RejectStatus.loading ||
                    state.paymentStatus == PaymentStatus.loading) {
                  return const CircularProgressIndicator();
                }
                if (state.requestStatus == LoanContractRequestStatus.pending) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseButton(
                        title: "Từ chối",
                        colorButton: AppColors.red,
                        width: 43.wp,
                        isLoading: state.rejectStatus == RejectStatus.loading,
                        onClick: () {
                          showCommentForm(context);
                        },
                      ),
                      BaseButton(
                        title: "Đồng ý",
                        width: 43.wp,
                        isLoading: state.confirmStatus == ConfirmStatus.loading,
                        onClick: () async {
                          context
                              .read<RequestDetailBloc>()
                              .add(ConfirmRequest(post));
                        },
                      ),
                    ],
                  );
                }
                if (state.requestStatus ==
                    LoanContractRequestStatus.waitingForPayment) {
                  return BaseButton(
                    title: "Thanh toán",
                    width: 100.wp,
                    isLoading: state.paymentStatus == PaymentStatus.loading,
                    onClick: () async {
                      // await controller.payContractFee(post);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

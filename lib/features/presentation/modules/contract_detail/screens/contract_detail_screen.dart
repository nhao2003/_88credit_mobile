import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/utils/add_months_date.dart';
import 'package:_88credit_mobile/core/utils/bank_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/entities/contract.dart';
import '../../../../domain/entities/user.dart';
import '../../../globalwidgets/base_button.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../../pdf_view/pdf_viewer_screen.dart';
import '../../post_detail/widgets/description_card.dart';
import '../../request_detail.dart/widgets/credit_card.dart';
import '../../request_detail.dart/widgets/loan_amount_card.dart';
import '../../request_detail.dart/widgets/more_request_info_card.dart';
import '../../request_detail.dart/widgets/received_amount_item.dart';
import '../../request_detail.dart/widgets/user_card.dart';

class ContractDetailScreen extends StatefulWidget {
  const ContractDetailScreen({super.key});

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  late ContractEntity post;

  late bool isPurchase;

  void navToPdfScreen(ContractEntity contract) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PdfViewerScreen(contract: contract);
    }));
  }

  void navToProfile(UserEntity user) {
    Navigator.pushNamed(context, AppRoutes.userProfile, arguments: user);
  }

  void copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    context.snackBar(
      "Đã copy",
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    if (data == null) {
      return const Scaffold(
        body: Center(
          child: Text("Không có dữ liệu"),
        ),
      );
    }
    post = data[0] as ContractEntity;
    isPurchase = data[1] as bool;

    return Scaffold(
      appBar: MyAppbar(
        title: "Chi tiết hợp đồng",
        actions: [
          if (isPurchase)
            TextButton(
              onPressed: () {
                navToPdfScreen(post);
              },
              child: Text(
                "Xem PDF",
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
              title: "Tổng số tiền người vay sẽ nhận",
              moneyRequest: post.amount!,
            ),
            const SizedBox(height: 20),
            LoanAmountCard(
              contractId: post.id,
              loanAmount: post.amount!,
              interestAmount: 50000,
              serviceCharge: 10000,
            ),
            const SizedBox(height: 20),
            MoreRequestInfo(
              loanTenureMonths: post.tenureInMonths!,
              interestRate: post.interestRate!,
              overdueInterestRate: post.overdueInterestRate!,
              loanReasonType: post.loanReasonType!,
              dateLoan: post.createdAt!,
              datePay: AddMonthDate.addMonthsToDateTime(
                  post.createdAt!, post.tenureInMonths!),
            ),
            const SizedBox(height: 20),
            UserCard(
              title: "Người cho vay",
              name: post.lender!.fullName,
              avatar: post.lender!.avatar!,
              navToProfile: () => navToProfile(post.lender!),
            ),
            const SizedBox(height: 20),
            CreditCard(
              buttonText: "Sao chép",
              bankName: post.lenderBankCard!.bank!.shortName,
              bankNumber:
                  BankFormat.formatCardNumber(post.lenderBankCard!.cardNumber!),
              logoBank: post.lenderBankCard!.bank!.logo,
              hanleChooseCard: () {
                copyToClipboard(post.lenderBankCard!.cardNumber!);
              },
            ),
            const SizedBox(height: 20),
            UserCard(
              title: "Người nhận",
              name: post.borrower!.fullName,
              avatar: post.borrower!.avatar!,
              navToProfile: () => navToProfile(post.borrower!),
            ),
            const SizedBox(height: 20),
            CreditCard(
              bankName: post.borrowerBankCard!.bank!.shortName,
              bankNumber: BankFormat.formatCardNumber(
                  post.borrowerBankCard!.cardNumber!),
              logoBank: post.borrowerBankCard!.bank!.logo,
              hanleChooseCard: () {
                copyToClipboard(post.borrowerBankCard!.cardNumber!);
              },
            ),
            const SizedBox(height: 20),
            DescriptionCard(
              title: "Mô tả lý do vay",
              description: post.loanReason!,
            ),
            const SizedBox(height: 20),
            if (!isPurchase)
              BaseButton(
                title: "Xem bản PDF",
                width: 100.wp,
                isLoading: true,
                onClick: () {
                  navToPdfScreen(post);
                },
              ),
          ],
        ),
      ),
    );
  }
}

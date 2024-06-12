import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/bank_bloc.dart';
import '../widgets/bank_card_list.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BankBloc>().add(GetBankCard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: "Thay đổi thẻ ngân hàng"),
      body: BlocBuilder<BankBloc, BankState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<BankBloc>().add(GetBankCard());
            },
            child: state.getBankCardStatus == GetBankCardStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.listBankCards.isEmpty
                    ? Center(
                        child: Text(
                          "Bạn chưa có thẻ ngân hàng nào",
                          style: AppTextStyles.bold16.colorEx(
                            AppColors.green,
                          ),
                        ),
                      )
                    : BankCardList(
                        listBanks: state.listBankCards,
                        onTap: (bank) {
                          context
                              .read<BankBloc>()
                              .add(MarkAsPrimaryCard(bank));
                        },
                        onDeleteCard: (card) {
                          context.read<BankBloc>().add(DeleteBankCard(card));
                        },
                      ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.bankList).then((value) {
            context.read<BankBloc>().add(GetBankCard());
          });
        },
        backgroundColor: AppColors.green,
        extendedPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        label: Text(
          "Thêm thẻ",
          style: AppTextStyles.bold12.colorEx(
            AppColors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:_88credit_mobile/features/presentation/modules/request/widgets/sent/request_item.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../bloc/request_bloc.dart';
import 'base_list_request.dart';

class WaitingPaymentRequestTab extends StatelessWidget {
  const WaitingPaymentRequestTab({super.key});

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListRequests(
        titleNull: "Chưa có tin đã đăng",
        requestType: RequestStatusTypes.waitingPayment,
      ),
    );
  }
}

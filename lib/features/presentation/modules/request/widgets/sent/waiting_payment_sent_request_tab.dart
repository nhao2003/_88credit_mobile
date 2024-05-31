import 'package:_88credit_mobile/features/presentation/modules/request/widgets/share_widgets/request_item.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../bloc/request_bloc.dart';
import 'base_list_sent_request.dart';

class WaitingPaymentSentRequestTab extends StatelessWidget {
  const WaitingPaymentSentRequestTab({super.key});

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListSentRequests(
        titleNull: "Chưa có yêu cầu đang chờ thanh toán",
        requestType: RequestStatusTypes.waitingPayment,
      ),
    );
  }
}

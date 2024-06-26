import 'package:flutter/material.dart';
import '../../../../../domain/enums/loan_contract_request_status.dart';
import 'base_list_sent_request.dart';

class PendingSentRequestTab extends StatelessWidget {
  const PendingSentRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListSentRequests(
        titleNull: "Chưa có yêu cầu đang chờ",
        requestType: LoanContractRequestStatus.pending,
      ),
    );
  }
}

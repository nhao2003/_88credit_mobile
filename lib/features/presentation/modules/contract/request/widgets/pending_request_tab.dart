import 'package:flutter/material.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../bloc/request/request_bloc.dart';
import 'base_list_request.dart';
import 'request_item.dart';

class PendingRequestTab extends StatelessWidget {
  const PendingRequestTab({super.key});

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  @override
  Widget build(BuildContext context) {    
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListRequests(
        titleNull: "Chưa có tin đã đăng",
        requestType: RequestStatusTypes.approved,
      ),
    );
  }
}

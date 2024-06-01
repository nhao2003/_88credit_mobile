import 'package:flutter/material.dart';
import '../../bloc/request_bloc.dart';
import 'base_list_sent_request.dart';

class PaidSentRequestTab extends StatelessWidget {
  const PaidSentRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListSentRequests(
        titleNull: "Chưa có yêu cầu thành công",
        requestType: RequestStatusTypes.paid,
      ),
    );
  }
}

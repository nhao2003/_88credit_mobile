import 'package:flutter/material.dart';
import '../../bloc/request_bloc.dart';
import 'base_list_received_request.dart';

class PaidReceivedRequestTab extends StatelessWidget {
  const PaidReceivedRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListReceivedRequests(
        titleNull: "Chưa có yêu cầu thành công",
        requestType: RequestStatusTypes.paid,
      ),
    );
  }
}

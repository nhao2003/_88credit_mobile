import 'package:flutter/material.dart';
import '../../bloc/request_bloc.dart';
import 'base_list_sent_request.dart';

class PendingSentRequestTab extends StatelessWidget {
  const PendingSentRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: BaseListSentRequests(
        titleNull: "Chưa có yêu cầu đang chờ",
        requestType: RequestStatusTypes.pending,
      ),
    );
  }
}

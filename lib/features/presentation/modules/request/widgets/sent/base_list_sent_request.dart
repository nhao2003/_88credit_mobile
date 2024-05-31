import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/bloc/request_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/widgets/share_widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../domain/enums/request_types.dart';

class BaseListSentRequests extends StatefulWidget {
  final RequestStatusTypes requestType;
  final String titleNull;
  const BaseListSentRequests({
    required this.requestType,
    required this.titleNull,
    super.key,
  });

  @override
  State<BaseListSentRequests> createState() => _BaseListSentRequestsState();
}

class _BaseListSentRequestsState extends State<BaseListSentRequests> {
  final scrollController = ScrollController();

  @override
  void initState() {
    refresh();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    context
        .read<RequestBloc>()
        .add(FetchMoreRequestEvent(RequestTypes.sent, widget.requestType));
  }

  Future refresh() async {
    context
        .read<RequestBloc>()
        .add(RefreshRequestEvent(RequestTypes.sent, widget.requestType));
  }

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  List<LoanRequestEntity> getRequests(RequestState state) {
    switch (widget.requestType) {
      case RequestStatusTypes.paid:
        return state.sentRequestsPaid;
      case RequestStatusTypes.waitingPayment:
        return state.sentRequestsWaitingPayment;
      case RequestStatusTypes.approved:
        return state.sentRequestsApproved;
      case RequestStatusTypes.pending:
        return state.sentRequestsPending;
      case RequestStatusTypes.rejected:
        return state.sentRequestsRejected;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<RequestBloc, RequestState>(
                builder: (context, state) {
                  List<LoanRequestEntity> requests = getRequests(state);
                  switch (state.status) {
                    case RequestFetchStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestFetchStatus.success:
                      if (requests.isEmpty) {
                        return Stack(
                          children: <Widget>[
                            ListView(),
                            Center(
                              child: Text(
                                widget.titleNull,
                                style: AppTextStyles.bold20
                                    .copyWith(color: AppColors.green),
                              ),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: requests.length + 1,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < requests.length) {
                            return buildItem(requests[index]);
                          } else {
                            return state.hasMoreSent
                                ? const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox(height: 20);
                          }
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

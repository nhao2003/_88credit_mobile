import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/bloc/request_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/widgets/share_widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';

class BaseListReceivedRequests extends StatefulWidget {
  final RequestStatusTypes requestType;
  final String titleNull;
  const BaseListReceivedRequests({
    required this.requestType,
    required this.titleNull,
    super.key,
  });

  @override
  State<BaseListReceivedRequests> createState() =>
      _BaseListReceivedRequestsState();
}

class _BaseListReceivedRequestsState extends State<BaseListReceivedRequests> {
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
    context.read<RequestBloc>().add(FetchMoreRequestEvent(widget.requestType));
  }

  Future refresh() async {
    context.read<RequestBloc>().add(RefreshRequestEvent(widget.requestType));
  }

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  List<LoanRequestEntity> getRequests(RequestState state) {
    switch (widget.requestType) {
      case RequestStatusTypes.approved:
        return state.requestsApproved;
      case RequestStatusTypes.pending:
        return state.requestsPending;
      case RequestStatusTypes.rejected:
        return state.requestsRejected;
      case RequestStatusTypes.sent:
        return state.requestsSent;
      case RequestStatusTypes.waitingPayment:
        return state.requestsWaitingPayment;
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
                            return state.hasMore
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

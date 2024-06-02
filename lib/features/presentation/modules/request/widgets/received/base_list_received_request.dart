import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/bloc/request_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/request/widgets/share_widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../../domain/enums/request_types.dart';

class BaseListReceivedRequests extends StatefulWidget {
  final LoanContractRequestStatus requestType;
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
    context
        .read<RequestBloc>()
        .add(FetchMoreRequestEvent(RequestTypes.received, widget.requestType));
  }

  Future refresh() async {
    context
        .read<RequestBloc>()
        .add(RefreshRequestEvent(RequestTypes.received, widget.requestType));
  }

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request, requestType: RequestTypes.received);
  }

  List<LoanRequestEntity> getRequests(RequestState state) {
    switch (widget.requestType) {
      case LoanContractRequestStatus.paid:
        return state.receivedRequestsPaid;
      case LoanContractRequestStatus.approved:
        return state.receivedRequestsApproved;
      case LoanContractRequestStatus.pending:
        return state.receivedRequestsPending;
      case LoanContractRequestStatus.rejected:
        return state.receivedRequestsRejected;
      case LoanContractRequestStatus.cancelled:
        return state.receivedRequestsCancelled;
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
                            return state.hasMoreReceived
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

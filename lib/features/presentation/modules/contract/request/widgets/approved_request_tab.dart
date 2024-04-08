import 'package:_88credit_mobile/features/domain/entities/loan_request.dart';
import 'package:_88credit_mobile/features/presentation/modules/contract/bloc/request/request_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/contract/request/widgets/request_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';

class ApprovedRequestTab extends StatefulWidget {
  const ApprovedRequestTab({super.key});

  @override
  State<ApprovedRequestTab> createState() => _ApprovedRequestTabState();
}

class _ApprovedRequestTabState extends State<ApprovedRequestTab> {
  final scrollController = ScrollController();
  final String titleNull = "Chưa có yêu cầu đã đăng";

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
        .add(const FetchMoreRequestEvent(RequestStatusTypes.approved));
  }

  Future refresh() async {
    context
        .read<RequestBloc>()
        .add(const RefreshRequestEvent(RequestStatusTypes.approved));
  }

  Widget? buildItem(LoanRequestEntity request) {
    return RequestItem(request: request);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              children: [
                Expanded(
                  child: state.status == RequestFetchStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.requestsApproved.isEmpty
                          ? Stack(
                              children: <Widget>[
                                ListView(),
                                Center(
                                  child: Text(
                                    titleNull,
                                    style: AppTextStyles.bold20
                                        .copyWith(color: AppColors.green),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: state.requestsApproved.length + 1,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index < state.requestsApproved.length) {
                                  return buildItem(
                                      state.requestsApproved[index]);
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
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

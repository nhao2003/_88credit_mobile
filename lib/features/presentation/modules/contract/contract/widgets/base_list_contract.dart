import 'package:_88credit_mobile/features/domain/enums/post_type.dart';
import 'package:_88credit_mobile/features/presentation/modules/contract/bloc/contract/contract_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/contract/contract/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../domain/entities/contract.dart';

class BaseListContract extends StatefulWidget {
  final PostTypes type;
  final String titleNull;
  const BaseListContract({
    required this.type,
    required this.titleNull,
    super.key,
  });

  @override
  State<BaseListContract> createState() => _BaseListContractState();
}

class _BaseListContractState extends State<BaseListContract> {
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
    context.read<ContractBloc>().add(FetchMoreContractEvent(widget.type));
  }

  Future refresh() async {
    context.read<ContractBloc>().add(RefreshContractEvent(widget.type));
  }

  Widget? buildItem(ContractEntity contract) {
    return ContractItem(contract);
  }

  List<ContractEntity> getContracts(ContractState state) {
    switch (widget.type) {
      case PostTypes.lending:
        return state.lendingContracts;
      case PostTypes.borrowing:
        return state.borrowingContracts;
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
              child: BlocBuilder<ContractBloc, ContractState>(
                builder: (context, state) {
                  List<ContractEntity> contracts = getContracts(state);
                  switch (state.status) {
                    case ContractFetchStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ContractFetchStatus.success:
                      if (contracts.isEmpty) {
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
                        itemCount: contracts.length + 1,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < contracts.length) {
                            return buildItem(contracts[index]);
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

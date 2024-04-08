import 'package:flutter/material.dart';
import '../../../../../domain/entities/contract.dart';
import '../../../../../domain/enums/post_type.dart';
import 'base_list_contract.dart';
import 'contract_item.dart';

class LendingContractTab extends StatelessWidget {
  const LendingContractTab({super.key});

  Widget? buildItem(ContractEntity contract) {
    return ContractItem(contract);
  }

  @override
  Widget build(BuildContext context) {
    return const BaseListContract(
      titleNull: "Chưa có hợp đồng nào",
      type: PostTypes.lending,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../globalwidgets/keep_page_alive.dart';
import '../widgets/borrowing_contract_tab.dart';
import '../widgets/lending_contract_tab.dart';

class ContractTabScreen extends StatefulWidget {
  const ContractTabScreen({super.key});

  @override
  State<ContractTabScreen> createState() => _ContractTabScreenState();
}

class _ContractTabScreenState extends State<ContractTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.green,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: "Cho vay",
              ),
              Tab(
                text: "Vay tiền",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                KeepPageAlive(child: LendingContractTab()),
                KeepPageAlive(child: BorrowingContractTab()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
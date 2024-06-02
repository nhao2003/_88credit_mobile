import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../globalwidgets/keep_page_alive.dart';
import '../widgets/received/approved_received_request_tab.dart';
import '../widgets/received/paid_received_request_tab.dart';
import '../widgets/received/pending_received_request_tab.dart';
import '../widgets/received/reject_received_request_tab.dart';

class RequestReceivedTabScreen extends StatefulWidget {
  const RequestReceivedTabScreen({super.key});

  @override
  State<RequestReceivedTabScreen> createState() =>
      _RequestReceivedTabScreenState();
}

class _RequestReceivedTabScreenState extends State<RequestReceivedTabScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.green,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              SizedBox(
                width: 100.wp / 5,
                child: const Tab(
                  text: "Thành công",
                ),
              ),
              SizedBox(
                width: 100.wp / 4,
                child: const Tab(
                  text: "Đã xác nhận",
                ),
              ),
              SizedBox(
                width: 100.wp / 4,
                child: const Tab(
                  text: "Chờ xác nhận",
                ),
              ),
              SizedBox(
                width: 100.wp / 5,
                child: const Tab(
                  text: "Đã hủy",
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                KeepPageAlive(child: PaidReceivedRequestTab()),
                KeepPageAlive(child: ApprovedReceivedRequestTab()),
                KeepPageAlive(child: PendingReceivedRequestTab()),
                KeepPageAlive(child: RejectReceivedRequestTab()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

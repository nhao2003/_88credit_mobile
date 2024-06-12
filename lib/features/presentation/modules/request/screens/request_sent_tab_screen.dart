import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../globalwidgets/keep_page_alive.dart';
import '../widgets/sent/approved_sent_request_tab.dart';
import '../widgets/sent/pending_sent_request_tab.dart';
import '../widgets/sent/reject_sent_request_tab.dart';
import '../widgets/sent/paid_sent_request_tab.dart';

class RequestSentTabScreen extends StatefulWidget {
  const RequestSentTabScreen({super.key});

  @override
  State<RequestSentTabScreen> createState() => _RequestSentTabScreenState();
}

class _RequestSentTabScreenState extends State<RequestSentTabScreen>
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
                KeepPageAlive(child: PaidSentRequestTab()),
                KeepPageAlive(child: ApprovedSentRequestTab()),
                KeepPageAlive(child: PendingSentRequestTab()),
                KeepPageAlive(child: RejectSentRequestTab()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

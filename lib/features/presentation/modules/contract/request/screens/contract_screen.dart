import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../globalwidgets/my_tab_appbar.dart';
import 'request_tab_screen.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const MyTabAppbar(
          title: "Hợp đồng",
          tabTitle1: "Yêu cầu",
          tabTitle2: "Hợp đồng",
          leading: SizedBox(),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            RequestTabScreen(),
            // ContractTabScreen(),
            // Scaffold(),
            Scaffold(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.createRequest);
          },
          backgroundColor: AppColors.green,
          extendedPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          label: Text(
            "Tạo yêu cầu",
            style: AppTextStyles.bold12.colorEx(
              AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

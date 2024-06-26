import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/my_tab_appbar.dart';
import 'request_received_tab_screen.dart';
import 'request_sent_tab_screen.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyTabAppbar(
          title: "Yêu cầu",
          tabTitle1: "Đã nhận",
          tabTitle2: "Đã gửi",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.contract);
                },
                icon: const HeroIcon(
                  HeroIcons.clipboardDocumentList,
                  style: HeroIconStyle.outline,
                  color: AppColors.grey700,
                ),
              ),
            ),
          ],
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            RequestReceivedTabScreen(),
            RequestSentTabScreen(),
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

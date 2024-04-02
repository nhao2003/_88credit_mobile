import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../globalwidgets/keep_page_alive.dart';
import '../../../globalwidgets/my_tab_appbar.dart';
import 'borrow_tab_screen.dart';
import 'lending_tab_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyTabAppbar(
          title: "Bài đăng",
          tabTitle1: "Vay tiền",
          tabTitle2: "Cho vay",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: AppColors.grey500,
                ),
              ),
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(
                Icons.bookmark_border_outlined,
                size: 25,
              ),
              color: AppColors.grey500,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            KeepPageAlive(child: BorrowTabScreen()),
            KeepPageAlive(child: LendingTabScreen()),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../config/theme/app_color.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({
    required this.title,
    this.isShowBack = true,
    this.actions,
    super.key,
  });

  final String title;
  final bool? isShowBack;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          color: AppColors.black,
          height: 1.0,
        ),
      ),
      leading: (isShowBack == true)
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                color: AppColors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : const SizedBox(),
      // ),
      actions: actions,
    );
  }
}

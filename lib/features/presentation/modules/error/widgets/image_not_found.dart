import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 18.hp),
          Image.asset(
            Assets.notFound,
            width: 50.wp,
          ),
          SizedBox(height: 5.hp),
          Text(
            "Trang này không thể hiển thị được!",
            style: AppTextStyles.bold18.colorEx(AppColors.green),
          ),
        ],
      ),
    );
  }
}

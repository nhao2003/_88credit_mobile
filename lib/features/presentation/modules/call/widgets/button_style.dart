import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';

//button style

final buttonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.green,
  padding: const EdgeInsets.symmetric(vertical: 15),
  textStyle: const TextStyle(color: AppColors.white),
  elevation: 10,
  minimumSize: Size(100.wp, 55),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

//button text style
final buttonTextStyle = AppTextStyles.bold14.colorEx(AppColors.white);

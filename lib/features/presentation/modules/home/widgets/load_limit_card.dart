import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../bloc/home_bloc.dart';
import 'my_tabbar.dart';

class LoadLimitCard extends StatelessWidget {
  const LoadLimitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: AppColors.grey200,
        ),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                state.currentIndexTab == 0
                    ? "Hạn mức vay tối đa"
                    : "Hạn mức cho vay tối đa",
                style: AppTextStyles.medium16,
              ),
              const SizedBox(height: 5),
              Text(
                state.currentIndexTab == 0
                    ? "${state.lendLimit.formatNumberWithCommas} VNĐ"
                    : "${state.borrowLimit.formatNumberWithCommas} VNĐ",
                style: AppTextStyles.bold30.colorEx(AppColors.green),
              ),
              const SizedBox(height: 10),
              const MyTabbar(),
            ],
          );
        },
      ),
    );
  }
}

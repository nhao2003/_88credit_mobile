import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../bloc/home_bloc.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isShowLended = true;
  bool isShowBorrowed = true;

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
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Đã vay:    ',
                      style: AppTextStyles.medium14.colorEx(AppColors.black),
                      children: <InlineSpan>[
                        TextSpan(
                          text: isShowLended
                              ? "****** VNĐ"
                              : '${state.lendedUsed.formatNumberWithCommas} VNĐ',
                          style: AppTextStyles.bold14.colorEx(AppColors.green),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkResponse(
                    onTap: () {
                      setState(() {
                        isShowLended = !isShowLended;
                      });
                    },
                    child: Image.asset(
                      isShowLended ? Assets.eyeOff : Assets.eye,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
                color: AppColors.grey200,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Cho vay:  ',
                      style: AppTextStyles.medium14.colorEx(AppColors.black),
                      children: <InlineSpan>[
                        TextSpan(
                          text: isShowBorrowed
                              ? "****** VNĐ"
                              : '${state.borrowedUsed.formatNumberWithCommas} VNĐ',
                          style: AppTextStyles.bold14.colorEx(AppColors.green),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkResponse(
                    onTap: () {
                      setState(() {
                        isShowBorrowed = !isShowBorrowed;
                      });
                    },
                    child: Image.asset(
                      isShowBorrowed ? Assets.eyeOff : Assets.eye,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

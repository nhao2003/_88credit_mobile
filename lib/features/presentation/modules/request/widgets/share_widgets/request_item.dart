import 'package:_88credit_mobile/core/extensions/date_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../../config/values/asset_image.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../../domain/enums/request_types.dart';

class RequestItem extends StatelessWidget {
  final LoanRequestEntity request;
  final RequestTypes requestType;
  const RequestItem(
      {required this.request, required this.requestType, super.key});

  final int numOfStars = 4;

  onTapPost(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.requestDetail, arguments: [request, requestType]);
  }

  onTapAvatar(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.userProfile, arguments: request.sender);
  }

  Widget _buildStars() {
    return Row(
      children: List.generate(
        5,
        (index) => Image.asset(
          Assets.star,
          width: 14,
          height: 14,
          color: index < numOfStars ? AppColors.yellow : AppColors.grey200,
        ),
      ),
    );
  }

  String getStatusText() {
    switch (request.status!) {
      case LoanContractRequestStatus.paid:
        return "Đã thanh toán từ ${request.updatedAt!.toDMYString()}";
      case LoanContractRequestStatus.approved:
        return "Đã xác nhận từ ${request.updatedAt!.toDMYString()}";
      case LoanContractRequestStatus.pending:
        return "Đang chờ xác nhận từ ${request.updatedAt!.toDMYString()}";
      case LoanContractRequestStatus.cancelled:
        return "Đã xóa từ ${request.updatedAt!.toDMYString()}";
      case LoanContractRequestStatus.rejected:
        return request.rejectedReason ?? "Đã hủy";
    }
  }

  Color getColorStatus() {
    switch (request.status!) {
      case LoanContractRequestStatus.paid:
        return AppColors.green800;
      case LoanContractRequestStatus.approved:
        return AppColors.blue800;
      case LoanContractRequestStatus.rejected:
        return AppColors.red800;
      case LoanContractRequestStatus.cancelled:
        return AppColors.grey700;
      case LoanContractRequestStatus.pending:
        return AppColors.yellow800;
    }
  }

  Color getColorBackground() {
    switch (request.status!) {
      case LoanContractRequestStatus.paid:
        return AppColors.green100;
      case LoanContractRequestStatus.approved:
        return AppColors.blue100;
      case LoanContractRequestStatus.rejected:
        return AppColors.red100;
      case LoanContractRequestStatus.cancelled:
        return AppColors.grey100;
      case LoanContractRequestStatus.pending:
        return AppColors.yellow100;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double widthItem = 80;
    return Column(
      children: [
        // user
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // avatar
            if (request.sender!.avatar != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: request.sender!.avatar!,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  errorWidget: (context, _, __) {
                    return const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Assets.avatar2),
                    );
                  },
                ),
              )
            else
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(Assets.avatar2),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name and stars
                      GestureDetector(
                        onTap: () => onTapAvatar(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.sender!.fullName,
                              style: AppTextStyles.semiBold14.colorEx(
                                const Color.fromARGB(255, 83, 49, 49),
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildStars(),
                          ],
                        ),
                      ),
                      // days and contact button
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              request.status ==
                                      LoanContractRequestStatus.pending
                                  ? "Xác nhận"
                                  : "Chi tiết",
                              style: AppTextStyles.semiBold12.colorEx(
                                AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // thong tin chi tiet
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: getColorBackground(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      getStatusText(),
                      style: AppTextStyles.medium12
                          .copyWith(color: getColorStatus()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => onTapPost(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: widthItem,
                                child: Text(
                                  "Số tiền:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${request.loanAmount!.toInt().formatNumberWithCommas} VNĐ",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: widthItem,
                                child: Text(
                                  "Kỳ hạn:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${request.loanTenureMonths} tháng",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: widthItem,
                                child: Text(
                                  "Lãi suất:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${request.interestRate} % / tháng",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: widthItem,
                                child: Text(
                                  "Ls quá hạn:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${request.overdueInterestRate} % / tháng",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                width: widthItem,
                                child: Text(
                                  "Lý do vay:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                request.loanReasonType!.toStringVi(),
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.clock,
                            width: 13,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            request.createdAt!.getTimeAgoVi(),
                            style: AppTextStyles.regular10.colorEx(
                              AppColors.grey400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.grey200,
          thickness: 1,
          height: 30,
        )
      ],
    );
  }
}

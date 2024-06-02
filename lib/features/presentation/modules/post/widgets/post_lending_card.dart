import 'package:_88credit_mobile/core/extensions/date_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/post_type.dart';
import 'save_button.dart';

// ignore: must_be_immutable
class PostLendingCard extends StatelessWidget {
  final PostEntity post;

  PostLendingCard({required this.post, super.key});

  final int numOfStars = 4;

  bool isLiked = false;

  toggleIsLiked() {
    isLiked = !isLiked;
  }

  onTapPost(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.postDetail, arguments: post);
  }

  onTapAvatar(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.userProfile, arguments: post.user);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // user
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // avatar
            if (post.user!.avatar != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: post.user!.avatar!,
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
                        onTap: () {
                          onTapAvatar(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${post.user!.firstName} ${post.user!.lastName}",
                              //"Phan Văn Minh",
                              style: AppTextStyles.semiBold14.colorEx(
                                AppColors.black,
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
                          Row(
                            children: [
                              Image.asset(
                                Assets.clock,
                                width: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "${post.duration} - ${post.maxDuration} tháng",
                                style: AppTextStyles.regular12.colorEx(
                                  AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
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
                              "Liên hệ",
                              style: AppTextStyles.semiBold12.colorEx(
                                AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // content
                  const SizedBox(height: 10),
                  // loai bai dang: Vay tien
                  Row(
                    children: [
                      Text(
                        "Loại bài đăng: ",
                        style: AppTextStyles.medium10,
                      ),
                      Text(
                        post.type == PostTypes.lending ? "Cho vay" : "Vay tiền",
                        style: AppTextStyles.bold10.colorEx(AppColors.green),
                      ),
                    ],
                  ),
                  // title
                  const SizedBox(height: 10),
                  Text(
                    post.title!,
                    maxLines: 3,
                    style: AppTextStyles.regular12.colorEx(AppColors.black),
                  ),
                  // thong tin chi tiet
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      onTapPost(context);
                    },
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
                                width: 80,
                                child: Text(
                                  "Số tiền:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${post.amount!.toInt().formatNumberWithCommas} - ${post.maxAmount!.toInt().formatNumberWithCommas} VND",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "Lãi suất:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${post.interestRate} - ${post.maxInterestRate} %/tháng",
                                style: AppTextStyles.bold12
                                    .colorEx(AppColors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "Ls quá hạn:",
                                  style: AppTextStyles.regular12
                                      .colorEx(AppColors.black),
                                ),
                              ),
                              Text(
                                "${post.overdueInterestRate} - ${post.maxOverdueInterestRate} %/tháng",
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
                            post.createdAt!.getTimeAgoVi(),
                            style: AppTextStyles.regular10.colorEx(
                              AppColors.grey400,
                            ),
                          ),
                        ],
                      ),
                      const SaveButton(),
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

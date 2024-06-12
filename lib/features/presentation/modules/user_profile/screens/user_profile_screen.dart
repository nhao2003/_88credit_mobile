import 'dart:io';

import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/core/extensions/date_ex.dart';
import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/screens/dialog_report.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/widgets/button_follow.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/widgets/tab_profile.dart';
import 'package:_88credit_mobile/features/presentation/modules/user_profile/widgets/verify_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/user_profile_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserEntity user = const UserEntity();

  void showCommentForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DialogReport(
        user: user,
        handleReportUser: handleReportUser,
      ),
    );
  }

  void handleReportUser(UserEntity user, String reason, File image) {
    print(reason);
  }

  @override
  Widget build(BuildContext context) {
    double sizeImage = 22.wp;
    user = ModalRoute.of(context)!.settings.arguments as UserEntity;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppbar(
            title: user.fullName,
            actions: [
              state.isMe
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          showCommentForm(context);
                        },
                        icon: const Icon(
                          Icons.outlined_flag_rounded,
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //avatar ========================================
                        if (user.avatar != null)
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: CachedNetworkImage(
                              imageUrl: user.avatar!,
                              fit: BoxFit.cover,
                              width: sizeImage,
                              height: sizeImage,
                              errorWidget: (context, _, __) {
                                return CircleAvatar(
                                  radius: sizeImage / 2,
                                  backgroundImage:
                                      const AssetImage(Assets.avatar2),
                                );
                              },
                            ),
                          )
                        else
                          CircleAvatar(
                            radius: sizeImage / 2,
                            backgroundImage: const AssetImage(Assets.avatar2),
                          ),
                        const SizedBox(width: 10),
                        // info ========================================
                        Expanded(
                          child: Column(
                            children: [
                              // info
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Bai viet
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.numberPost.toString(),
                                          style: AppTextStyles.semiBold16
                                              .colorEx(AppColors.grey700),
                                        ),
                                        Text(
                                          "Bài viết",
                                          style: AppTextStyles.medium12
                                              .colorEx(AppColors.grey700),
                                        ),
                                      ],
                                    ),
                                    // Người theo dõi
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.numberFollower.toString(),
                                          style: AppTextStyles.semiBold16
                                              .colorEx(AppColors.grey700),
                                        ),
                                        Text(
                                          "Người theo dõi",
                                          style: AppTextStyles.medium12
                                              .colorEx(AppColors.grey700),
                                        ),
                                      ],
                                    ),
                                    // Đang theo dõi
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.numberFollowing.toString(),
                                          style: AppTextStyles.semiBold16
                                              .colorEx(AppColors.grey700),
                                        ),
                                        Text(
                                          "Đang theo dõi",
                                          style: AppTextStyles.medium12
                                              .colorEx(AppColors.grey700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              // button follow
                              ButtonFollow(
                                isFollow: state.isFollow,
                                isMe: state.isMe,
                                onTap: () {
                                  context
                                      .read<UserProfileBloc>()
                                      .add(const FollowUser());
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // name ============================================
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          user.fullName,
                          style: AppTextStyles.semiBold16
                              .colorEx(AppColors.grey700),
                        ),
                        const SizedBox(width: 5),
                        const VerifyComponent(isVerify: true, isMe: true),
                      ],
                    ),
                    // location ========================================
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.location,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 80.wp,
                          child: Text(
                            user.address ?? "Chưa cập nhật địa chỉ",
                            style: AppTextStyles.medium14
                                .colorEx(AppColors.grey500),
                          ),
                        )
                      ],
                    ),
                    // dateCreate ======================================
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.calendar,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 80.wp,
                          child: user.createdAt != null
                              ? Text(
                                  "Tham gia ngày ${(user.createdAt!.toDMYString())}",
                                  style: AppTextStyles.medium14
                                      .colorEx(AppColors.grey500),
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // tab ==============================================
              const TabProfile(),
            ],
          ),
          floatingActionButton: state.isMe
              ? Container()
              : FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.createRequest, arguments: user);
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
        );
      },
    );
  }
}

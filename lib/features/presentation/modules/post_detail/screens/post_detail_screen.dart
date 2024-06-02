import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/date_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/presentation/globalwidgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/post_type.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../widgets/description_card.dart';
import '../widgets/info_card.dart';
import '../widgets/user_card.dart';

//ignore: must_be_immutable
class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  PostEntity post = const PostEntity();

  final int numOfStars = 4;

  void navToUserProfile(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.userProfile, arguments: post.user);
  }

  @override
  Widget build(BuildContext context) {
    post = ModalRoute.of(context)!.settings.arguments as PostEntity;
    return Scaffold(
      appBar: MyAppbar(title: post.title!),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCard(
              name: post.user!.fullName,
              numOfStars: numOfStars,
              avatar: post.user!.avatar,
              navToUserProfile: () => navToUserProfile(context),
              onContact: () {},
            ),
// Loai bai dang
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Loại bài đăng: ",
                  style: AppTextStyles.regular12.colorEx(AppColors.grey500),
                ),
                const SizedBox(width: 2),
                Text(
                  post.type == PostTypes.lending ? "Cho vay" : "Vay tiền",
                  style: AppTextStyles.bold12.colorEx(AppColors.green),
                ),
              ],
            ),
// time created
            const SizedBox(height: 10),
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.clock,
                  size: 14,
                  color: AppColors.grey500,
                ),
                const SizedBox(width: 5),
                Text(
                  post.createdAt!.getTimeAgoVi(),
                  style: AppTextStyles.regular10.colorEx(AppColors.grey500),
                ),
              ],
            ),
// Tieu de
            const SizedBox(height: 10),
            Text(
              post.title!,
              style: AppTextStyles.regular14.colorEx(AppColors.black),
            ),
// thong tin
            const SizedBox(height: 15),
            InfoCard(post: post),
// hinh anh
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Hình ảnh",
                style: AppTextStyles.bold14.colorEx(AppColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageCard(images: post.images!),
            ),
// Mô tả
            const SizedBox(height: 10),
            DescriptionCard(
              title: "Mô tả",
              description: post.description!,
            ),
// lý do vay
            const SizedBox(height: 20),
            DescriptionCard(
              title: post.type == PostTypes.lending
                  ? "Lý do cho vay"
                  : "Lý do vay",
              description: post.loanReasonDescription!,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

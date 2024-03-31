import 'package:flutter/material.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/entities/blog.dart';
import '../../../globalwidgets/carousel_ad.dart';
import '../widgets/blog_card.dart';
import '../widgets/border_image_button.dart';
import '../widgets/home_appbar.dart';
import '../widgets/load_limit_card.dart';
import '../widgets/report_card.dart';
import '../widgets/util_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> imgList = [
    'https://tinnhiemmang.vn/storage/photos/shares/tin-tuc/tt2022/10211a.jpg',
    'https://cdn.tima.vn/content-image/2020/4/2020440_vay-40tr-khong-the-chap.jpg',
    'https://cdn.tuoitre.vn/471584752817336320/2023/9/20/photo-1695177142803-16951771434652004020101.jpg',
    'https://image.congan.com.vn/thumbnail/CATP-480-2023-4-28/nhung-app-vay-tien-bi-bat-1_637_382_326.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1em0CudPUva4SQdZ522Qx6UA6jsDed5OA0w&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Appbar
              const HomeAppbar(),
              // CarouselAd
              const SizedBox(height: 20),
              const LoadLimitCard(),
              // loan limit
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Thống kê",
                      style: AppTextStyles.bold14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ReportCard(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderImageButton(
                    title: "Vay ngay",
                    image: Assets.borrow,
                    onTap: () {},
                  ),
                  BorderImageButton(
                    title: "Cho vay",
                    image: Assets.creditor,
                    onTap: () {},
                  ),
                ],
              ),

              // quang cao
              const SizedBox(height: 15),
              CarouselAd(
                imgList: imgList,
                aspectRatio: 2.59,
                indicatorSize: 6,
              ),

              // text tin tuc
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Tin tức",
                      style: AppTextStyles.bold14,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.blog);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "Xen thêm >",
                        style: AppTextStyles.light12,
                      ),
                    ),
                  ),
                ],
              ),

              // tin tuc
              const SizedBox(height: 10),
              // Container(
              //   width: 100.wp,
              //   constraints: BoxConstraints(maxHeight: 25.hp),
              //   child: FutureBuilder<List<BlogEntity>>(
              //     future: controller.getBlogs(),
              //     builder: (context, snapShot) {
              //       if (!snapShot.hasData) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else {
              //         List<BlogEntity> data = snapShot.data!;
              //         return ListView.separated(
              //           shrinkWrap: true,
              //           itemCount: data.length,
              //           scrollDirection: Axis.horizontal,
              //           separatorBuilder: (BuildContext context, int index) =>
              //               const SizedBox(
              //             width: 10,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return BlogCard(
              //               key: UniqueKey(),
              //               blog: data[index],
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              // ),

              // cac tien ich khac
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Các tiện ích khác",
                      style: AppTextStyles.bold14,
                    ),
                  ),
                ],
              ),

              // cards
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UtilCard(
                    title: "Tính lãi suất",
                    image: Assets.financialProfit,
                    onTap: () {},
                  ),
                  UtilCard(
                    title: "Lịch sử GD",
                    image: Assets.history,
                    onTap: () {},
                  ),
                  UtilCard(
                    title: "Báo cáo",
                    image: Assets.schedule,
                    onTap: () {},
                  ),
                  UtilCard(
                    title: "Hỗ trợ",
                    image: Assets.chatbot,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

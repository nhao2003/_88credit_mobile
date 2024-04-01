import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../globalwidgets/carousel_ad.dart';
import '../bloc/home_bloc.dart';
import '../widgets/blog_card.dart';
import '../widgets/border_image_button.dart';
import '../widgets/home_appbar.dart';
import '../widgets/load_limit_card.dart';
import '../widgets/report_card.dart';
import '../widgets/util_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchBlogs());
  }

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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return CarouselAd(
                    imgList: state.listAds,
                    aspectRatio: 2.59,
                    indicatorSize: 6,
                  );
                },
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
              Container(
                width: 100.wp,
                constraints: BoxConstraints(maxHeight: 25.hp),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case BlogStatus.initial:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case BlogStatus.success:
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.blogs.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            width: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return BlogCard(
                              key: UniqueKey(),
                              blog: state.blogs[index],
                            );
                          },
                        );
                      case BlogStatus.failure:
                        return const Center(
                          child: Text("Failed to fetch posts"),
                        );
                    }
                  },
                ),
              ),

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

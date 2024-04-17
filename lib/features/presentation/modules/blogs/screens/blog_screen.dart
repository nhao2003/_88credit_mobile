import 'package:_88credit_mobile/features/presentation/modules/home/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:_88credit_mobile/features/presentation/modules/blogs/screens/blog_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../globalwidgets/my_appbar.dart';
import '../bloc/blog_bloc.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: 'Blogs',
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state.status == BlogStatus.initial) {
            context.read<BlogBloc>().add(FetchBlogScreens());
          }
          if (state.status == BlogStatus.failure) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (state.status == BlogStatus.success) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BlogDetailScreen(),
                          settings:
                              RouteSettings(arguments: state.blogs[index]),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: state.blogs[index].thumbnail,
                              fit: BoxFit.cover,
                              height: 23.hp,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.blogs[index].shortDescription,
                                  style: AppTextStyles.bold16,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  state.blogs[index].shortDescription,
                                  style: AppTextStyles.light12
                                      .colorEx(AppColors.grey500),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

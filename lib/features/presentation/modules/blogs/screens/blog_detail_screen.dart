import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/date_ex.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entities/blog.dart';
import '../../../globalwidgets/my_appbar.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlogEntity blog;
    return Scaffold(
        appBar: const MyAppbar(title: "Chi tiết bài viết"),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: AppTextStyles.bold24.copyWith(color: AppColors.green),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  blog.shortDescription,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      blog.author,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(blog.createdAt.getTimeAgoVi())
                  ],
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(microseconds: 500)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Html(
                        data: blog.content,
                        onLinkTap: (url, attributes, element) async {
                          await launchUrl(
                            Uri.parse(url!),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}

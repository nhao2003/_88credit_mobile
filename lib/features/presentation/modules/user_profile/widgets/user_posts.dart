import 'package:flutter/material.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/post_type.dart';
import '../../post/widgets/base_list_posts.dart';
import '../../post/widgets/post_borrow_card.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

  Widget? buildItem(PostEntity post) {
    return PostBorrowCard(post: post);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BaseListPosts(
        postType: PostTypes.borrowing,
        buildItem: buildItem,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/post_type.dart';
import '../widgets/base_list_posts.dart';
import '../widgets/card_sort.dart';
import '../widgets/post_borrow_card.dart';

class BorrowTabScreen extends StatelessWidget {
  const BorrowTabScreen({super.key});

  Widget? buildItem(PostEntity post) {
    return PostBorrowCard(post: post);
  }

  Widget? buildCardSort() {
    return const CardSort();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BaseListPosts(
        cardSort: buildCardSort(),
        buildItem: buildItem,
        postType: PostTypes.borrowing,
      ),
    );
  }
}

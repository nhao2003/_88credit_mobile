import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';
import '../widgets/base_list_posts.dart';
import '../widgets/card_sort.dart';
import '../widgets/post_lending_card.dart';

class LendingTabScreen extends StatelessWidget {
  const LendingTabScreen({super.key});

  Widget? buildItem(PostEntity post) {
    return PostLendingCard(post: post);
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
      ),
    );
  }
}

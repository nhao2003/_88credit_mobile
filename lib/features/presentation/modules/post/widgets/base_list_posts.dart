import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/post.dart';
import '../bloc/post_bloc.dart';

class BaseListPosts extends StatefulWidget {
  final Widget? Function(PostEntity post) buildItem;
  final String titleNull;
  final Widget? cardSort;
  const BaseListPosts(
      {required this.buildItem,
      this.cardSort,
      this.titleNull = "Chưa có tin đã đăng",
      super.key});

  @override
  State<BaseListPosts> createState() => _BaseListPostsState();
}

class _BaseListPostsState extends State<BaseListPosts> {
  final scrollController = ScrollController();

  @override
  void initState() {
    refresh();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    context.read<PostBloc>().add(FetchMorePostEnvent());
  }

  Future refresh() async {
    context.read<PostBloc>().add(RefreshPostEnvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: refresh,
          child: Column(
            children: [
              widget.cardSort != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: widget.cardSort,
                    )
                  : const SizedBox(),
              Expanded(
                child: state.lendingStatus == PostLendingStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.lendingPosts.isEmpty
                        ? Center(
                            child: Text(
                              widget.titleNull,
                              style: AppTextStyles.bold20
                                  .copyWith(color: AppColors.green),
                            ),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: state.lendingPosts.length + 1,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < state.lendingPosts.length) {
                                return widget
                                    .buildItem(state.lendingPosts[index]);
                              } else {
                                return state.hasMore
                                    ? const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox(height: 20);
                              }
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}

part of 'post_bloc.dart';

enum PostFetchStatus { loading, success, failure }

final class PostState extends Equatable {
  final PostFetchStatus status;
  final List<PostEntity> lendingPosts;
  final List<PostEntity> borrowingPosts;
  final bool hasMore;
  final TypeSort typeSort;

  const PostState({
    this.status = PostFetchStatus.loading,
    this.lendingPosts = const [],
    this.borrowingPosts = const [],
    this.hasMore = true,
    this.typeSort = TypeSort.amountIncrease,
  });

  PostState copyWith({
    PostFetchStatus? status,
    List<PostEntity>? lendingPosts,
    List<PostEntity>? borrowingPosts,
    bool? hasMore,
    TypeSort? typeSort,
  }) {
    return PostState(
      status: status ?? this.status,
      lendingPosts: lendingPosts ?? this.lendingPosts,
      borrowingPosts: borrowingPosts ?? this.borrowingPosts,
      hasMore: hasMore ?? this.hasMore,
      typeSort: typeSort ?? this.typeSort,
    );
  }

  @override
  List<Object> get props => [
        status,
        lendingPosts,
        borrowingPosts,
        hasMore,
        typeSort,
      ];
}

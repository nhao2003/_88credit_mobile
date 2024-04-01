part of 'post_bloc.dart';

enum PostLendingStatus { loading, success, failure }

enum PostBorrowingStatus { loading, success, failure }

final class PostState extends Equatable {
  final PostLendingStatus lendingStatus;
  final List<PostEntity> lendingPosts;
  final PostBorrowingStatus borrowingStatus;
  final List<PostEntity> borrowingPosts;
  final bool hasMore;

  const PostState({
    this.lendingStatus = PostLendingStatus.loading,
    this.lendingPosts = const [],
    this.borrowingStatus = PostBorrowingStatus.loading,
    this.borrowingPosts = const [],
    this.hasMore = true,
  });

  PostState copyWith({
    PostLendingStatus? lendingStatus,
    List<PostEntity>? lendingPosts,
    PostBorrowingStatus? borrowingStatus,
    List<PostEntity>? borrowingPosts,
    bool? hasMore,
  }) {
    return PostState(
      lendingStatus: lendingStatus ?? this.lendingStatus,
      lendingPosts: lendingPosts ?? this.lendingPosts,
      borrowingStatus: borrowingStatus ?? this.borrowingStatus,
      borrowingPosts: borrowingPosts ?? this.borrowingPosts,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object> get props => [
        lendingStatus,
        lendingPosts,
        borrowingStatus,
        borrowingPosts,
        hasMore,
      ];
}

part of 'user_profile_bloc.dart';

enum GetUserPostsStatus { loading, success, failure }

final class UserProfileState extends Equatable {
  final GetUserPostsStatus getUserPostsStatus;
  final int numberPost;
  final int numberFollower;
  final int numberFollowing;
  final bool isFollow;
  final bool isMe;
  final String numOfPosts;
  final List<PostEntity> userPosts;

  const UserProfileState({
    this.getUserPostsStatus = GetUserPostsStatus.loading,
    this.numberPost = 0,
    this.numberFollower = 0,
    this.numberFollowing = 0,
    this.isFollow = false,
    this.isMe = false,
    this.numOfPosts = "-",
    this.userPosts = const [],
  });

  UserProfileState copyWith({
    GetUserPostsStatus? getUserPostsStatus,
    int? numberPost,
    int? numberFollower,
    int? numberFollowing,
    bool? isFollow,
    bool? isMe,
    String? numOfPosts,
    List<PostEntity>? userPosts,
  }) {
    return UserProfileState(
      getUserPostsStatus: getUserPostsStatus ?? this.getUserPostsStatus,
      numberPost: numberPost ?? this.numberPost,
      numberFollower: numberFollower ?? this.numberFollower,
      numberFollowing: numberFollowing ?? this.numberFollowing,
      isFollow: isFollow ?? this.isFollow,
      isMe: isMe ?? this.isMe,
      numOfPosts: numOfPosts ?? this.numOfPosts,
      userPosts: userPosts ?? this.userPosts,
    );
  }

  @override
  List<Object> get props => [
        getUserPostsStatus,
        numberPost,
        numberFollower,
        numberFollowing,
        isFollow,
        isMe,
        numOfPosts,
        userPosts,
      ];
}

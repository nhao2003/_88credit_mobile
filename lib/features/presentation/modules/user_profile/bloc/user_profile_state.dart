part of 'user_profile_bloc.dart';

enum GetUserPostsStatus { loading, success, failure }

enum GetUserProfileStatus { loading, success, failure }

final class UserProfileState extends Equatable {
  final GetUserPostsStatus getUserPostsStatus;
  final GetUserProfileStatus getUserProfileStatus;
  final UserEntity user;
  final int numberPost;
  final int numberFollower;
  final int numberFollowing;
  final bool isFollow;
  final bool isMe;
  final String numOfPosts;
  final List<PostEntity> userPosts;

  const UserProfileState({
    this.getUserPostsStatus = GetUserPostsStatus.loading,
    this.getUserProfileStatus = GetUserProfileStatus.loading,
    this.user = const UserEntity(),
    this.numberPost = 5,
    this.numberFollower = 1,
    this.numberFollowing = 2,
    this.isFollow = false,
    this.isMe = false,
    this.numOfPosts = "-",
    this.userPosts = const [],
  });

  UserProfileState copyWith({
    GetUserPostsStatus? getUserPostsStatus,
    GetUserProfileStatus? getUserProfileStatus,
    UserEntity? user,
    int? numberPost,
    int? numberFollower,
    int? numberFollowing,
    bool? isFollow,
    bool? isMe,
    String? numOfPosts,
    List<PostEntity>? userPosts,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      getUserPostsStatus: getUserPostsStatus ?? this.getUserPostsStatus,
      getUserProfileStatus: getUserProfileStatus ?? this.getUserProfileStatus,
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
        user,
        getUserPostsStatus,
        getUserProfileStatus,
        numberPost,
        numberFollower,
        numberFollowing,
        isFollow,
        isMe,
        numOfPosts,
        userPosts,
      ];
}

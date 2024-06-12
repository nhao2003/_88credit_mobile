part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfile extends UserProfileEvent {
  final String userId;
  const GetUserProfile(
    this.userId,
  );

  @override
  List<Object> get props => [userId];
}

class GetUserPosts extends UserProfileEvent {
  const GetUserPosts();
}

class CheckIsMe extends UserProfileEvent {
  const CheckIsMe();
}

class FollowUser extends UserProfileEvent {
  const FollowUser();
}

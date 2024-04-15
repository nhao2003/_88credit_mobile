part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
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

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/post_status.dart';
import '../../../../domain/enums/post_type.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';
part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(const UserProfileState()) {
    on<UserProfileEvent>((event, emit) {});
    on<GetUserPosts>(_onGetUserPosts);
    on<CheckIsMe>(_checkIsMe);
    on<FollowUser>(_followUser);
  }

  void _checkIsMe(
    CheckIsMe event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(isMe: false));
  }

  void _followUser(
    FollowUser event,
    Emitter<UserProfileState> emit,
  ) {
    emit(state.copyWith(isFollow: !state.isFollow));
  }

  Future<void> _onGetUserPosts(
    GetUserPosts event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(getUserPostsStatus: GetUserPostsStatus.loading));
    try {
      final posts = await _getUserPosts();
      emit(
        state.copyWith(
          getUserPostsStatus: GetUserPostsStatus.success,
          userPosts: posts.second,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getUserPostsStatus: GetUserPostsStatus.failure,
        ),
      );
    }
  }

  Future<Pair<int, List<PostEntity>>> _getUserPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      List.generate(
        5,
        (index) => PostEntity(
          id: index.toString(),
          user: user,
          status: PostStatus.APPROVED,
          loanReason: LoanReasonTypes.BUSINESS,
          loanReasonDescription: 'Business',
          type: PostTypes.lending,
          title: 'Title $index',
          description: 'Description $index',
          images: const [
            'https://img.cand.com.vn/resize/800x800/NewFiles/Images/2022/06/15/vay_tien_khong_tra_co_bi_di_tu_2-1655284202853.jpg',
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-ep0T17eQH5S3seorTt57qLqW-vm9N9v00L_ol_VXOQ&s",
          ],
          interestRate: 0.1,
          amount: 1000,
          duration: 12,
          overdueInterestRate: 0.2,
          maxInterestRate: 0.3,
          maxAmount: 2000,
          maxDuration: 24,
          maxOverdueInterestRate: 0.4,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ),
    );
  }

  UserEntity get user => UserEntity(
        id: '1',
        status: UserStatus.verified,
        isIdentityVerified: true,
        role: Role.user,
        email: 'a@a.com',
        address: null,
        firstName: 'John',
        lastName: 'Doe',
        gender: true,
        avatar:
            'https://i.pinimg.com/736x/8a/6a/a8/8a6aa88d7b7efd82c7ddbf296dc401eb.jpg',
        dob: '1990-01-01',
        phone: '0123456789',
        lastActiveAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/post_status.dart';
import '../../../../domain/enums/post_type.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<PostEvent>((event, emit) {});
    on<GetLendingPostEnvent>(_onGetLendingPost);
    on<GetBorrowingPostEnvent>(_onGetBorrowingPost);
    on<RefreshPostEnvent>(_refresh);
    on<FetchMorePostEnvent>(_fetchMore);
  }

  Future<void> _onGetLendingPost(
    GetLendingPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(lendingStatus: PostLendingStatus.loading));
    try {
      final posts = await _getPostsLending();
      emit(
        state.copyWith(
          lendingStatus: PostLendingStatus.success,
          lendingPosts: posts.second,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          lendingStatus: PostLendingStatus.failure,
        ),
      );
    }
  }

  Future<Pair<int, List<PostEntity>>> _getPostsLending() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      List.generate(
        5,
        (index) => PostEntity(
          id: index.toString(),
          user: user,
          type: PostTypes.lending,
          loanReasonType: LoanReasonTypes.business,
          loanReason: 'Business',
          status: PostStatus.approved,
          title: 'Title $index',
          description: 'Description $index',
          images: const [
            'https://img.cand.com.vn/resize/800x800/NewFiles/Images/2022/06/15/vay_tien_khong_tra_co_bi_di_tu_2-1655284202853.jpg',
          ],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          interestRate: 0.1,
          loanAmount: 1000,
          tenureMonths: 12,
          overdueInterestRate: 0.2,
          maxInterestRate: 0.3,
          maxLoanAmount: 2000,
          maxTenureMonths: 24,
          maxOverdueInterestRate: 0.4,
        ),
      ),
    );
  }

  Future<void> _onGetBorrowingPost(
    GetBorrowingPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(borrowingStatus: PostBorrowingStatus.loading));
    try {
      final posts = await _getPostsBorrowing();
      emit(
        state.copyWith(
          borrowingStatus: PostBorrowingStatus.success,
          borrowingPosts: posts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          borrowingStatus: PostBorrowingStatus.failure,
        ),
      );
    }
  }

  Future<List<PostEntity>> _getPostsBorrowing() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(
      5,
      (index) => PostEntity(
        id: index.toString(),
        user: user,
        type: PostTypes.borrowing,
        loanReasonType: LoanReasonTypes.business,
        loanReason: 'Business',
        status: PostStatus.approved,
        title: 'Title $index',
        description: 'Description $index',
        images: const [
          'https://img.cand.com.vn/resize/800x800/NewFiles/Images/2022/06/15/vay_tien_khong_tra_co_bi_di_tu_2-1655284202853.jpg',
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        interestRate: 0.1,
        loanAmount: 1000,
        tenureMonths: 12,
        overdueInterestRate: 0.2,
        maxInterestRate: 0.3,
        maxLoanAmount: 2000,
        maxTenureMonths: 24,
        maxOverdueInterestRate: 0.4,
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
        avatar: 'https://www.google.com',
        dob: '1990-01-01',
        phone: '0123456789',
        lastActiveAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  int page = 1;
  int numOfPage = 1;
  bool hasMore = true;

  Future<void> _refresh(
    RefreshPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      lendingStatus: PostLendingStatus.loading,
      lendingPosts: [],
      hasMore: hasMore,
    ));
    await _getPostsLending().then((value) {
      numOfPage = value.first;
      state.lendingPosts.clear();
      final newPosts = value.second;
      state.lendingPosts.addAll(newPosts);
      numOfPage == 1 ? hasMore = false : hasMore = true;

      return emit(state.copyWith(
        lendingStatus: PostLendingStatus.success,
        lendingPosts: state.lendingPosts,
        hasMore: hasMore,
      ));
    });
  }

  Future<void> _fetchMore(
    FetchMorePostEnvent event,
    Emitter<PostState> emit,
  ) async {
    page++;
    emit(state.copyWith(
      lendingStatus: PostLendingStatus.loading,
    ));
    if (page < numOfPage) {
      // Fetch more data and add to the list
      await _getPostsLending().then((value) {
        numOfPage = value.first;
        final newPosts = value.second;
        state.lendingPosts.addAll(newPosts);
        hasMore = true;
        return emit(state.copyWith(
          lendingStatus: PostLendingStatus.success,
          lendingPosts: state.lendingPosts,
          hasMore: hasMore,
        ));
      });
    } else {
      // No more pages to fetch
      hasMore = false;
      emit(state.copyWith(
        lendingStatus: PostLendingStatus.success,
        lendingPosts: state.lendingPosts,
        hasMore: hasMore,
      ));
    }
  }
}

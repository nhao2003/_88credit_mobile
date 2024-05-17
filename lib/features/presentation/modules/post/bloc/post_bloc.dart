import 'package:_88credit_mobile/features/domain/entities/address.dart';
import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:_88credit_mobile/features/domain/usecases/post/get_posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/post_status.dart';
import '../../../../domain/enums/post_type.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';
import '../widgets/card_sort.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<PostEvent>((event, emit) {});
    on<GetLendingPostEnvent>(_onGetLendingPost);
    on<GetBorrowingPostEnvent>(_onGetBorrowingPost);
    on<RefreshPostEnvent>(_refresh);
    on<FetchMorePostEnvent>(_fetchMore);
    on<ChangeSortType>(_changeSortType);
  }

  Future<void> _changeSortType(
    ChangeSortType event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(typeSort: event.typeSort));
  }

  Future<void> _onGetLendingPost(
    GetLendingPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostFetchStatus.loading));
    try {
      final posts = await _getPostsLending();
      emit(
        state.copyWith(
          status: PostFetchStatus.success,
          lendingPosts: posts.second,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostFetchStatus.failure,
        ),
      );
    }
  }

  Future<Pair<int, List<PostEntity>>> _getPostsLending() async {
    final GetPostsUseCase getPostsUseCase = sl<GetPostsUseCase>();
    final dataState = await getPostsUseCase(params: Pair(null, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      print(dataState.data!);
      //return dataState.data!;
    } else {
      print('error');
      // return Pair(1, []);
    }
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
          isLease: true,
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

  Future<void> _onGetBorrowingPost(
    GetBorrowingPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostFetchStatus.loading));
    try {
      final posts = await _getPostsBorrowing();
      emit(
        state.copyWith(
          status: PostFetchStatus.success,
          borrowingPosts: posts.second,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostFetchStatus.failure,
        ),
      );
    }
  }

  Future<Pair<int, List<PostEntity>>> _getPostsBorrowing() async {
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
          isLease: false,
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
        address: address,
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

  AddressEntity get address => AddressEntity(
        provinceCode: 1,
        districtCode: 1,
        wardCode: 1,
        detail: '123 ABC',
      );

  int page = 1;
  int numOfPage = 1;
  bool hasMore = true;

  Future<void> _refresh(
    RefreshPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    if (event.postType == PostTypes.lending) {
      await refreshLending(event, emit);
    } else {
      await refreshBorrowing(event, emit);
    }
  }

  Future refreshLending(
    RefreshPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: PostFetchStatus.loading,
      lendingPosts: [],
      hasMore: hasMore,
    ));
    await _getPostsLending().then((value) {
      numOfPage = value.first;
      final newPosts = value.second;
      numOfPage == 1 ? hasMore = false : hasMore = true;

      emit(state.copyWith(
        status: PostFetchStatus.success,
        lendingPosts: newPosts,
        hasMore: hasMore,
      ));
    });
  }

  Future refreshBorrowing(
    RefreshPostEnvent event,
    Emitter<PostState> emit,
  ) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: PostFetchStatus.loading,
      borrowingPosts: [],
      hasMore: hasMore,
    ));
    await _getPostsBorrowing().then((value) {
      numOfPage = value.first;
      final newPosts = value.second;
      numOfPage == 1 ? hasMore = false : hasMore = true;

      emit(state.copyWith(
        status: PostFetchStatus.success,
        borrowingPosts: newPosts,
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
      status: PostFetchStatus.loading,
    ));
    if (page < numOfPage) {
      // Fetch more data and add to the list
      if (event.postType == PostTypes.lending) {
        await _getPostsLending().then((value) {
          numOfPage = value.first;
          final newPosts = value.second;
          state.lendingPosts.addAll(newPosts);
          hasMore = true;
          return emit(state.copyWith(
            status: PostFetchStatus.success,
            lendingPosts: state.lendingPosts,
            hasMore: hasMore,
          ));
        });
      } else {
        await _getPostsBorrowing().then((value) {
          numOfPage = value.first;
          final newPosts = value.second;
          state.borrowingPosts.addAll(newPosts);
          hasMore = true;
          return emit(state.copyWith(
            status: PostFetchStatus.success,
            borrowingPosts: state.borrowingPosts,
            hasMore: hasMore,
          ));
        });
      }
    } else {
      // No more pages to fetch
      hasMore = false;
      emit(state.copyWith(
        status: PostFetchStatus.success,
        lendingPosts: state.lendingPosts,
        borrowingPosts: state.borrowingPosts,
        hasMore: hasMore,
      ));
    }
  }
}

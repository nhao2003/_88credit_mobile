import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/resources/pair.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../../domain/enums/loan_reason_types.dart';
import '../../../../../domain/enums/role.dart';
import '../../../../../domain/enums/user_status.dart';
part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(const RequestState()) {
    on<RequestEvent>((event, emit) {});
    on<RefreshRequestEvent>(_refreshRequest);
    on<FetchMoreRequestEvent>(_fetchMoreRequest);
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestApproved() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestPending() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestRejected() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestSent() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestWaitingPayment() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(),
    );
  }

  List<LoanRequestEntity> getRequests() {
    return List.generate(
      5,
      (index) => LoanRequestEntity(
        id: index.toString(),
        status: LoanContractRequestStatus.paid,
        sender: user,
        receiver: user,
        description: 'Description $index',
        loanAmount: 1000,
        interestRate: 0.1,
        overdueInterestRate: 0.2,
        loanTenureMonths: 12,
        loanReasonType: LoanReasonTypes.business,
        loanReason: 'Business',
        videoConfirmation:
            'https://videos.pexels.com/video-files/6548176/6548176-hd_1920_1080_24fps.mp4',
        portaitPhoto:
            'https://preview.redd.it/cute-chinese-girl-prompt-v0-unj4c2swcfeb1.png?auto=webp&s=fe872406e39269fa69244e138cf7cfb252c3be51',
        idCardFrontPhoto:
            'https://static.ttbc-hcm.gov.vn/images/upload/lienphuong/04102021//cccd_bodm.jpg',
        idCardBackPhoto:
            'https://static.ttbc-hcm.gov.vn/images/upload/lienphuong/04102021//cccd_bodm.jpg',
        senderBankCardId: '1',
        receiverBankCardId: '2',
        senderBankCard: null,
        receiverBankCard: null,
        rejectedReason: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
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

  int page = 1;
  int numOfPage = 1;
  bool hasMore = true;
  Future _refreshRequest(
      RefreshRequestEvent event, Emitter<RequestState> emit) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: RequestFetchStatus.loading,
      requestsApproved: [],
      hasMore: hasMore,
    ));

    final Pair<int, List<LoanRequestEntity>> result;
    switch (event.requestStatusType) {
      case RequestStatusTypes.approved:
        result = await _getRequestApproved();
        break;
      case RequestStatusTypes.pending:
        result = await _getRequestPending();
        break;
      case RequestStatusTypes.rejected:
        result = await _getRequestRejected();
        break;
      case RequestStatusTypes.sent:
        result = await _getRequestSent();
        break;
      case RequestStatusTypes.waitingPayment:
        result = await _getRequestWaitingPayment();
        break;
    }

    numOfPage = result.first;
    final newPosts = result.second;
    numOfPage == 1 ? hasMore = false : hasMore = true;

    switch (event.requestStatusType) {
      case RequestStatusTypes.approved:
        return emit(state.copyWith(
          status: RequestFetchStatus.success,
          requestsApproved: newPosts,
          hasMore: hasMore,
        ));
      case RequestStatusTypes.pending:
        return emit(state.copyWith(
          status: RequestFetchStatus.success,
          requestsApproved: newPosts,
          hasMore: hasMore,
        ));
      case RequestStatusTypes.rejected:
        return emit(state.copyWith(
          status: RequestFetchStatus.success,
          requestsApproved: newPosts,
          hasMore: hasMore,
        ));
      case RequestStatusTypes.sent:
        return emit(state.copyWith(
          status: RequestFetchStatus.success,
          requestsApproved: newPosts,
          hasMore: hasMore,
        ));
      case RequestStatusTypes.waitingPayment:
        return emit(state.copyWith(
          status: RequestFetchStatus.success,
          requestsApproved: newPosts,
          hasMore: hasMore,
        ));
    }
  }

  Future _fetchMoreRequest(
      FetchMoreRequestEvent event, Emitter<RequestState> emit) async {
    if (page < numOfPage) {
      page++;
      emit(state.copyWith(
        status: RequestFetchStatus.loading,
      ));

      final Pair<int, List<LoanRequestEntity>> result;
      switch (event.requestStatusType) {
        case RequestStatusTypes.approved:
          result = await _getRequestApproved();
          state.requestsApproved.addAll(result.second);
          break;
        case RequestStatusTypes.pending:
          result = await _getRequestPending();
          state.requestsPending.addAll(result.second);
          break;
        case RequestStatusTypes.rejected:
          result = await _getRequestRejected();
          state.requestsRejected.addAll(result.second);
          break;
        case RequestStatusTypes.sent:
          result = await _getRequestSent();
          state.requestsSent.addAll(result.second);
          break;
        case RequestStatusTypes.waitingPayment:
          result = await _getRequestWaitingPayment();
          state.requestsWaitingPayment.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      switch (event.requestStatusType) {
        case RequestStatusTypes.approved:
          return emit(state.copyWith(
            status: RequestFetchStatus.success,
            requestsApproved: state.requestsApproved,
            hasMore: hasMore,
          ));
        case RequestStatusTypes.pending:
          return emit(state.copyWith(
            status: RequestFetchStatus.success,
            requestsPending: state.requestsPending,
            hasMore: hasMore,
          ));
        case RequestStatusTypes.rejected:
          return emit(state.copyWith(
            status: RequestFetchStatus.success,
            requestsRejected: state.requestsRejected,
            hasMore: hasMore,
          ));
        case RequestStatusTypes.sent:
          return emit(state.copyWith(
            status: RequestFetchStatus.success,
            requestsSent: state.requestsSent,
            hasMore: hasMore,
          ));
        case RequestStatusTypes.waitingPayment:
          return emit(state.copyWith(
            status: RequestFetchStatus.success,
            requestsWaitingPayment: state.requestsWaitingPayment,
            hasMore: hasMore,
          ));
      }
    } else {
      hasMore = false;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMore: hasMore,
      ));
    }
  }
}

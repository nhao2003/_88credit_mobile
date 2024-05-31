import 'package:_88credit_mobile/di/injection_container.dart';
import 'package:_88credit_mobile/features/domain/entities/bank_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/bank.dart';
import '../../../../domain/entities/loan_request.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';
import '../../../../domain/usecases/contract/get_loan_requests_approved.dart';
import '../../../../domain/usecases/contract/get_loan_requests_reject.dart';
part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(const RequestState()) {
    on<RequestEvent>((event, emit) {});
    on<RefreshRequestEvent>(_refreshRequest);
    on<FetchMoreRequestEvent>(_fetchMoreRequest);
  }

  // { paid, waitingPayment, approved, pending, rejected }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestPaid(
      RequestTypes requestTypes,
      {int? page = 1}) async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.PENDING),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestWaitingPayment(
      RequestTypes requestTypes,
      {int? page = 1}) async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.WAITING_FOR_PAYMENT),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestApproved(
      RequestTypes requestTypes,
      {int? page = 1}) async {
    final GetRequestApprovedUseCase getPostsApprovedUseCase =
        sl<GetRequestApprovedUseCase>();

    final dataState = await getPostsApprovedUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestPending(
      RequestTypes requestTypes,
      {int? page = 1}) async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.PENDING),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestRejected(
      RequestTypes requestTypes,
      {int? page = 1}) async {
    final GetRequestRejectedUseCase getPostsApprovedUseCase =
        sl<GetRequestRejectedUseCase>();

    final dataState = await getPostsApprovedUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  List<LoanRequestEntity> getRequests(LoanContractRequestStatus? status) {
    return List.generate(
      5,
      (index) => LoanRequestEntity(
        id: index.toString(),
        status: status,
        sender: user,
        receiver: user,
        description: 'Description $index',
        loanAmount: 1000,
        interestRate: 0.1,
        overdueInterestRate: 0.2,
        loanTenureMonths: 12,
        loanReasonType: LoanReasonTypes.BUSINESS,
        loanReason: 'Business',
        videoConfirmationUrl:
            'https://videos.pexels.com/video-files/6548176/6548176-hd_1920_1080_24fps.mp4',
        portaitPhotoUrl:
            'https://preview.redd.it/cute-chinese-girl-prompt-v0-unj4c2swcfeb1.png?auto=webp&s=fe872406e39269fa69244e138cf7cfb252c3be51',
        idCardFrontPhotoUrl:
            'https://static.ttbc-hcm.gov.vn/images/upload/lienphuong/04102021//cccd_bodm.jpg',
        idCardBackPhotoUrl:
            'https://static.ttbc-hcm.gov.vn/images/upload/lienphuong/04102021//cccd_bodm.jpg',
        senderBankCardId: '1',
        receiverBankCardId: '2',
        senderBankCard: bankCard,
        receiverBankCard: bankCard,
        rejectedReason: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  BankCardEntity get bankCard => BankCardEntity(
        id: '1',
        isPrimary: true,
        userId: '1',
        bankId: '1',
        cardNumber: '1234567890',
        branch: 'Branch',
        bank: bank,
        createdAt: DateTime.now(),
        deletedAt: null,
      );
  BankEntity get bank => const BankEntity(
        id: '1',
        name: 'Bank',
        shortName: 'Bank',
        logo:
            'https://baobitrungthanh.com/wp-content/uploads/2024/01/logo-ngan-hang-agribank-40.jpg',
        code: '123',
        bin: '123',
      );

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
    if (event.requestType == RequestTypes.sent) {
      return _refreshSentRequest(event, emit);
    } else {
      return _refreshReceivedRequest(event, emit);
    }
  }

  Future _refreshReceivedRequest(
      RefreshRequestEvent event, Emitter<RequestState> emit) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: RequestFetchStatus.loading,
      hasMoreReceived: hasMore,
    ));

    final Pair<int, List<LoanRequestEntity>> result;
    switch (event.requestStatusType) {
      case RequestStatusTypes.paid:
        emit(state.copyWith(receivedRequestsPaid: []));
        result = await _getRequestPaid(RequestTypes.received);
        break;
      case RequestStatusTypes.waitingPayment:
        emit(state.copyWith(receivedRequestsWaitingPayment: []));
        result = await _getRequestWaitingPayment(RequestTypes.received);
        break;
      case RequestStatusTypes.approved:
        emit(state.copyWith(receivedRequestsApproved: []));
        result = await _getRequestApproved(RequestTypes.received);
        break;
      case RequestStatusTypes.pending:
        emit(state.copyWith(receivedRequestsPending: []));
        result = await _getRequestPending(RequestTypes.received);
        break;
      case RequestStatusTypes.rejected:
        emit(state.copyWith(receivedRequestsRejected: []));
        result = await _getRequestRejected(RequestTypes.received);
        break;
    }

    numOfPage = result.first;
    final newPosts = result.second;
    numOfPage == 1 ? hasMore = false : hasMore = true;

    emit(state.copyWith(
      status: RequestFetchStatus.success,
      hasMoreReceived: hasMore,
    ));
    switch (event.requestStatusType) {
      case RequestStatusTypes.paid:
        return emit(state.copyWith(receivedRequestsPaid: newPosts));
      case RequestStatusTypes.waitingPayment:
        return emit(state.copyWith(receivedRequestsWaitingPayment: newPosts));
      case RequestStatusTypes.approved:
        return emit(state.copyWith(receivedRequestsApproved: newPosts));
      case RequestStatusTypes.pending:
        return emit(state.copyWith(receivedRequestsPending: newPosts));
      case RequestStatusTypes.rejected:
        return emit(state.copyWith(receivedRequestsRejected: newPosts));
    }
  }

  Future _refreshSentRequest(
      RefreshRequestEvent event, Emitter<RequestState> emit) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: RequestFetchStatus.loading,
      hasMoreSent: hasMore,
    ));

    final Pair<int, List<LoanRequestEntity>> result;
    switch (event.requestStatusType) {
      case RequestStatusTypes.paid:
        emit(state.copyWith(sentRequestsPaid: []));
        result = await _getRequestPaid(RequestTypes.sent);
        break;
      case RequestStatusTypes.waitingPayment:
        emit(state.copyWith(sentRequestsWaitingPayment: []));
        result = await _getRequestWaitingPayment(RequestTypes.sent);
        break;
      case RequestStatusTypes.approved:
        emit(state.copyWith(sentRequestsApproved: []));
        result = await _getRequestApproved(RequestTypes.sent);
        break;
      case RequestStatusTypes.pending:
        emit(state.copyWith(sentRequestsPending: []));
        result = await _getRequestPending(RequestTypes.sent);
        break;
      case RequestStatusTypes.rejected:
        emit(state.copyWith(sentRequestsRejected: []));
        result = await _getRequestRejected(RequestTypes.sent);
        break;
    }

    numOfPage = result.first;
    final newPosts = result.second;
    numOfPage == 1 ? hasMore = false : hasMore = true;

    emit(state.copyWith(
      status: RequestFetchStatus.success,
      hasMoreSent: hasMore,
    ));
    switch (event.requestStatusType) {
      case RequestStatusTypes.paid:
        return emit(state.copyWith(sentRequestsPaid: newPosts));
      case RequestStatusTypes.waitingPayment:
        return emit(state.copyWith(sentRequestsWaitingPayment: newPosts));
      case RequestStatusTypes.approved:
        return emit(state.copyWith(sentRequestsApproved: newPosts));
      case RequestStatusTypes.pending:
        return emit(state.copyWith(sentRequestsPending: newPosts));
      case RequestStatusTypes.rejected:
        return emit(state.copyWith(sentRequestsRejected: newPosts));
    }
  }

  Future _fetchMoreRequest(
      FetchMoreRequestEvent event, Emitter<RequestState> emit) async {
    if (event.requestType == RequestTypes.sent) {
      return _fetchMoreSentRequest(event, emit);
    } else {
      return _fetchMoreReceivedRequest(event, emit);
    }
  }

  Future _fetchMoreSentRequest(
      FetchMoreRequestEvent event, Emitter<RequestState> emit) async {
    if (page < numOfPage) {
      page++;
      emit(state.copyWith(
        status: RequestFetchStatus.loading,
      ));

      final Pair<int, List<LoanRequestEntity>> result;
      switch (event.requestStatusType) {
        case RequestStatusTypes.paid:
          result = await _getRequestPaid(RequestTypes.sent);
          state.sentRequestsPaid.addAll(result.second);
          break;
        case RequestStatusTypes.waitingPayment:
          result = await _getRequestWaitingPayment(RequestTypes.sent);
          state.sentRequestsWaitingPayment.addAll(result.second);
          break;
        case RequestStatusTypes.approved:
          result = await _getRequestApproved(RequestTypes.sent);
          state.sentRequestsApproved.addAll(result.second);
          break;
        case RequestStatusTypes.pending:
          result = await _getRequestPending(RequestTypes.sent);
          state.sentRequestsPending.addAll(result.second);
          break;
        case RequestStatusTypes.rejected:
          result = await _getRequestRejected(RequestTypes.sent);
          state.sentRequestsRejected.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreSent: hasMore,
      ));
      switch (event.requestStatusType) {
        case RequestStatusTypes.paid:
          return emit(state.copyWith(sentRequestsPaid: state.sentRequestsPaid));
        case RequestStatusTypes.waitingPayment:
          return emit(state.copyWith(
              sentRequestsWaitingPayment: state.sentRequestsWaitingPayment));
        case RequestStatusTypes.approved:
          return emit(
              state.copyWith(sentRequestsApproved: state.sentRequestsApproved));
        case RequestStatusTypes.pending:
          return emit(
              state.copyWith(sentRequestsPending: state.sentRequestsPending));
        case RequestStatusTypes.rejected:
          return emit(
              state.copyWith(sentRequestsRejected: state.sentRequestsRejected));
      }
    } else {
      hasMore = false;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreSent: hasMore,
      ));
    }
  }

  Future _fetchMoreReceivedRequest(
      FetchMoreRequestEvent event, Emitter<RequestState> emit) async {
    if (page < numOfPage) {
      page++;
      emit(state.copyWith(
        status: RequestFetchStatus.loading,
      ));

      final Pair<int, List<LoanRequestEntity>> result;
      switch (event.requestStatusType) {
        case RequestStatusTypes.paid:
          result = await _getRequestPaid(RequestTypes.sent);
          state.receivedRequestsPaid.addAll(result.second);
          break;
        case RequestStatusTypes.waitingPayment:
          result = await _getRequestWaitingPayment(RequestTypes.sent);
          state.receivedRequestsWaitingPayment.addAll(result.second);
          break;
        case RequestStatusTypes.approved:
          result = await _getRequestApproved(RequestTypes.sent);
          state.receivedRequestsApproved.addAll(result.second);
          break;
        case RequestStatusTypes.pending:
          result = await _getRequestPending(RequestTypes.sent);
          state.receivedRequestsPending.addAll(result.second);
          break;
        case RequestStatusTypes.rejected:
          result = await _getRequestRejected(RequestTypes.sent);
          state.receivedRequestsRejected.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreReceived: hasMore,
      ));
      switch (event.requestStatusType) {
        case RequestStatusTypes.paid:
          return emit(
              state.copyWith(receivedRequestsPaid: state.receivedRequestsPaid));
        case RequestStatusTypes.waitingPayment:
          return emit(state.copyWith(
              receivedRequestsWaitingPayment:
                  state.receivedRequestsWaitingPayment));
        case RequestStatusTypes.approved:
          return emit(state.copyWith(
              receivedRequestsApproved: state.receivedRequestsApproved));
        case RequestStatusTypes.pending:
          return emit(state.copyWith(
              receivedRequestsPending: state.receivedRequestsPending));
        case RequestStatusTypes.rejected:
          return emit(state.copyWith(
              receivedRequestsRejected: state.receivedRequestsRejected));
      }
    } else {
      hasMore = false;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreReceived: hasMore,
      ));
    }
  }
}

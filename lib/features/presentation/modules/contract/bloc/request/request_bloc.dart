import 'package:_88credit_mobile/di/injection_container.dart';
import 'package:_88credit_mobile/features/domain/entities/bank_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/resources/pair.dart';
import '../../../../../domain/entities/bank.dart';
import '../../../../../domain/entities/loan_request.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../../domain/enums/loan_reason_types.dart';
import '../../../../../domain/enums/role.dart';
import '../../../../../domain/enums/user_status.dart';
import '../../../../../domain/usecases/contract/get_loan_requests_approved.dart';
import '../../../../../domain/usecases/contract/get_loan_requests_reject.dart';
part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(const RequestState()) {
    on<RequestEvent>((event, emit) {});
    on<RefreshRequestEvent>(_refreshRequest);
    on<FetchMoreRequestEvent>(_fetchMoreRequest);
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestApproved(
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

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestPending() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.PENDING),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestRejected() async {
    final GetRequestRejectedUseCase getPostsApprovedUseCase =
        sl<GetRequestRejectedUseCase>();

    final dataState = await getPostsApprovedUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestSent() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.PENDING),
    );
  }

  Future<Pair<int, List<LoanRequestEntity>>> _getRequestWaitingPayment() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getRequests(LoanContractRequestStatus.WAITING_FOR_PAYMENT),
    );
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
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: RequestFetchStatus.loading,
      hasMore: hasMore,
    ));

    final Pair<int, List<LoanRequestEntity>> result;
    switch (event.requestStatusType) {
      case RequestStatusTypes.approved:
        emit(state.copyWith(requestsApproved: []));
        result = await _getRequestApproved();
        break;
      case RequestStatusTypes.pending:
        emit(state.copyWith(requestsPending: []));
        result = await _getRequestPending();
        break;
      case RequestStatusTypes.rejected:
        emit(state.copyWith(requestsRejected: []));
        result = await _getRequestRejected();
        break;
      case RequestStatusTypes.sent:
        emit(state.copyWith(requestsSent: []));
        result = await _getRequestSent();
        break;
      case RequestStatusTypes.waitingPayment:
        emit(state.copyWith(requestsWaitingPayment: []));
        result = await _getRequestWaitingPayment();
        break;
    }

    numOfPage = result.first;
    final newPosts = result.second;
    numOfPage == 1 ? hasMore = false : hasMore = true;

    emit(state.copyWith(
      status: RequestFetchStatus.success,
      hasMore: hasMore,
    ));
    switch (event.requestStatusType) {
      case RequestStatusTypes.approved:
        return emit(state.copyWith(requestsApproved: newPosts));
      case RequestStatusTypes.pending:
        return emit(state.copyWith(requestsPending: newPosts));
      case RequestStatusTypes.rejected:
        return emit(state.copyWith(requestsRejected: newPosts));
      case RequestStatusTypes.sent:
        return emit(state.copyWith(requestsSent: newPosts));
      case RequestStatusTypes.waitingPayment:
        return emit(state.copyWith(requestsWaitingPayment: newPosts));
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
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMore: hasMore,
      ));
      switch (event.requestStatusType) {
        case RequestStatusTypes.approved:
          return emit(state.copyWith(requestsApproved: state.requestsApproved));
        case RequestStatusTypes.pending:
          return emit(state.copyWith(requestsPending: state.requestsPending));
        case RequestStatusTypes.rejected:
          return emit(state.copyWith(requestsRejected: state.requestsRejected));
        case RequestStatusTypes.sent:
          return emit(state.copyWith(requestsSent: state.requestsSent));
        case RequestStatusTypes.waitingPayment:
          return emit(state.copyWith(
              requestsWaitingPayment: state.requestsWaitingPayment));
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

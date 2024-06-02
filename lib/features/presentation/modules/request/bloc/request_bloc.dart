import 'package:_88credit_mobile/di/injection_container.dart';
import 'package:_88credit_mobile/features/domain/usecases/contract/get_received_requests_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../domain/entities/loan_request.dart';
import '../../../../domain/enums/loan_contract_request_status.dart';
import '../../../../domain/enums/request_types.dart';
import '../../../../domain/usecases/contract/get_sent_requests_status.dart';
part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(const RequestState()) {
    on<RequestEvent>((event, emit) {});
    on<RefreshRequestEvent>(_refreshRequest);
    on<FetchMoreRequestEvent>(_fetchMoreRequest);
  }

  // { paid, waitingPayment, approved, pending, rejected }
  Future<Pair<int, List<LoanRequestEntity>>> _getRequest(
    RequestTypes requestTypes,
    LoanContractRequestStatus loanContractRequestStatus, {
    int? page = 1,
  }) async {
    final DataState<Pair<int, List<LoanRequestEntity>>> dataState;
    if (requestTypes == RequestTypes.sent) {
      final GetSentRequestStatusUseCase getRequestUseCase =
          sl<GetSentRequestStatusUseCase>();

      dataState = await getRequestUseCase(
          params: Pair(loanContractRequestStatus, page));
    } else {
      final GetReceivedRequestStatusUseCase getRequestUseCase =
          sl<GetReceivedRequestStatusUseCase>();

      dataState = await getRequestUseCase(
          params: Pair(loanContractRequestStatus, page));
    }
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

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
      case LoanContractRequestStatus.paid:
        emit(state.copyWith(receivedRequestsPaid: []));
        result = await _getRequest(
          RequestTypes.received,
          LoanContractRequestStatus.paid,
          page: page,
        );
        break;
      case LoanContractRequestStatus.approved:
        emit(state.copyWith(receivedRequestsApproved: []));
        result = await _getRequest(
          RequestTypes.received,
          LoanContractRequestStatus.approved,
          page: page,
        );
        break;
      case LoanContractRequestStatus.pending:
        emit(state.copyWith(receivedRequestsPending: []));
        result = await _getRequest(
          RequestTypes.received,
          LoanContractRequestStatus.pending,
          page: page,
        );
        break;
      case LoanContractRequestStatus.rejected:
        emit(state.copyWith(receivedRequestsRejected: []));
        result = await _getRequest(
          RequestTypes.received,
          LoanContractRequestStatus.rejected,
          page: page,
        );
        break;
      case LoanContractRequestStatus.cancelled:
        emit(state.copyWith(receivedRequestsCancelled: []));
        result = await _getRequest(
          RequestTypes.received,
          LoanContractRequestStatus.cancelled,
          page: page,
        );
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
      case LoanContractRequestStatus.paid:
        return emit(state.copyWith(receivedRequestsPaid: newPosts));
      case LoanContractRequestStatus.approved:
        return emit(state.copyWith(receivedRequestsApproved: newPosts));
      case LoanContractRequestStatus.pending:
        return emit(state.copyWith(receivedRequestsPending: newPosts));
      case LoanContractRequestStatus.rejected:
        return emit(state.copyWith(receivedRequestsRejected: newPosts));
      case LoanContractRequestStatus.cancelled:
        return emit(state.copyWith(receivedRequestsCancelled: newPosts));
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
      case LoanContractRequestStatus.paid:
        emit(state.copyWith(sentRequestsPaid: []));
        result = await _getRequest(
          RequestTypes.sent,
          LoanContractRequestStatus.paid,
          page: page,
        );
        break;
      case LoanContractRequestStatus.approved:
        emit(state.copyWith(sentRequestsApproved: []));
        result = await _getRequest(
          RequestTypes.sent,
          LoanContractRequestStatus.approved,
          page: page,
        );
        break;
      case LoanContractRequestStatus.pending:
        emit(state.copyWith(sentRequestsPending: []));
        result = await _getRequest(
          RequestTypes.sent,
          LoanContractRequestStatus.pending,
          page: page,
        );
        break;
      case LoanContractRequestStatus.rejected:
        emit(state.copyWith(sentRequestsRejected: []));
        result = await _getRequest(
          RequestTypes.sent,
          LoanContractRequestStatus.rejected,
          page: page,
        );
        break;
      case LoanContractRequestStatus.cancelled:
        emit(state.copyWith(sentRequestsCancelled: []));
        result = await _getRequest(
          RequestTypes.sent,
          LoanContractRequestStatus.cancelled,
          page: page,
        );
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
      case LoanContractRequestStatus.paid:
        return emit(state.copyWith(sentRequestsPaid: newPosts));
      case LoanContractRequestStatus.approved:
        return emit(state.copyWith(sentRequestsApproved: newPosts));
      case LoanContractRequestStatus.pending:
        return emit(state.copyWith(sentRequestsPending: newPosts));
      case LoanContractRequestStatus.rejected:
        return emit(state.copyWith(sentRequestsRejected: newPosts));
      case LoanContractRequestStatus.cancelled:
        return emit(state.copyWith(sentRequestsCancelled: newPosts));
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
        case LoanContractRequestStatus.paid:
          result = await _getRequest(
            RequestTypes.sent,
            LoanContractRequestStatus.paid,
            page: page,
          );
          state.sentRequestsPaid.addAll(result.second);
          break;
        case LoanContractRequestStatus.approved:
          result = await _getRequest(
            RequestTypes.sent,
            LoanContractRequestStatus.approved,
            page: page,
          );
          state.sentRequestsApproved.addAll(result.second);
          break;
        case LoanContractRequestStatus.pending:
          result = await _getRequest(
            RequestTypes.sent,
            LoanContractRequestStatus.pending,
            page: page,
          );
          state.sentRequestsPending.addAll(result.second);
          break;
        case LoanContractRequestStatus.rejected:
          result = await _getRequest(
            RequestTypes.sent,
            LoanContractRequestStatus.rejected,
            page: page,
          );
          state.sentRequestsRejected.addAll(result.second);
          break;
        case LoanContractRequestStatus.cancelled:
          result = await _getRequest(
            RequestTypes.sent,
            LoanContractRequestStatus.cancelled,
            page: page,
          );
          state.sentRequestsCancelled.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreSent: hasMore,
      ));
      switch (event.requestStatusType) {
        case LoanContractRequestStatus.paid:
          return emit(state.copyWith(sentRequestsPaid: state.sentRequestsPaid));
        case LoanContractRequestStatus.approved:
          return emit(
              state.copyWith(sentRequestsApproved: state.sentRequestsApproved));
        case LoanContractRequestStatus.pending:
          return emit(
              state.copyWith(sentRequestsPending: state.sentRequestsPending));
        case LoanContractRequestStatus.rejected:
          return emit(
              state.copyWith(sentRequestsRejected: state.sentRequestsRejected));
        case LoanContractRequestStatus.cancelled:
          return emit(state.copyWith(
              sentRequestsCancelled: state.sentRequestsCancelled));
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
        case LoanContractRequestStatus.paid:
          result = await _getRequest(
            RequestTypes.received,
            LoanContractRequestStatus.paid,
            page: page,
          );
          state.receivedRequestsPaid.addAll(result.second);
          break;
        case LoanContractRequestStatus.approved:
          result = await _getRequest(
            RequestTypes.received,
            LoanContractRequestStatus.approved,
            page: page,
          );
          state.receivedRequestsApproved.addAll(result.second);
          break;
        case LoanContractRequestStatus.pending:
          result = await _getRequest(
            RequestTypes.received,
            LoanContractRequestStatus.pending,
            page: page,
          );
          state.receivedRequestsPending.addAll(result.second);
          break;
        case LoanContractRequestStatus.rejected:
          result = await _getRequest(
            RequestTypes.received,
            LoanContractRequestStatus.rejected,
            page: page,
          );
          state.receivedRequestsRejected.addAll(result.second);
          break;
        case LoanContractRequestStatus.cancelled:
          result = await _getRequest(
            RequestTypes.received,
            LoanContractRequestStatus.cancelled,
            page: page,
          );
          state.receivedRequestsCancelled.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      emit(state.copyWith(
        status: RequestFetchStatus.success,
        hasMoreReceived: hasMore,
      ));
      switch (event.requestStatusType) {
        case LoanContractRequestStatus.paid:
          return emit(
              state.copyWith(receivedRequestsPaid: state.receivedRequestsPaid));
        case LoanContractRequestStatus.approved:
          return emit(state.copyWith(
              receivedRequestsApproved: state.receivedRequestsApproved));
        case LoanContractRequestStatus.pending:
          return emit(state.copyWith(
              receivedRequestsPending: state.receivedRequestsPending));
        case LoanContractRequestStatus.rejected:
          return emit(state.copyWith(
              receivedRequestsRejected: state.receivedRequestsRejected));
        case LoanContractRequestStatus.cancelled:
          return emit(state.copyWith(
              receivedRequestsCancelled: state.receivedRequestsCancelled));
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

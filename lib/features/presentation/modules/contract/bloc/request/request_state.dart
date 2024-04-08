part of 'request_bloc.dart';

enum RequestFetchStatus { loading, success, failure }

final class RequestState extends Equatable {
  final RequestFetchStatus status;
  final bool hasMore;
  final List<LoanRequestEntity> requestsApproved;
  final List<LoanRequestEntity> requestsPending;
  final List<LoanRequestEntity> requestsRejected;
  final List<LoanRequestEntity> requestsSent;
  final List<LoanRequestEntity> requestsWaitingPayment;

  const RequestState({
    this.status = RequestFetchStatus.loading,
    this.hasMore = true,
    this.requestsApproved = const [],
    this.requestsPending = const [],
    this.requestsRejected = const [],
    this.requestsSent = const [],
    this.requestsWaitingPayment = const [],
  });

  RequestState copyWith({
    RequestFetchStatus? status,
    bool? hasMore,
    List<LoanRequestEntity>? requestsApproved,
    List<LoanRequestEntity>? requestsPending,
    List<LoanRequestEntity>? requestsRejected,
    List<LoanRequestEntity>? requestsSent,
    List<LoanRequestEntity>? requestsWaitingPayment,
  }) {
    return RequestState(
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      requestsApproved: requestsApproved ?? this.requestsApproved,
      requestsPending: requestsPending ?? this.requestsPending,
      requestsRejected: requestsRejected ?? this.requestsRejected,
      requestsSent: requestsSent ?? this.requestsSent,
      requestsWaitingPayment:
          requestsWaitingPayment ?? this.requestsWaitingPayment,
    );
  }

  @override
  List<Object> get props => [
        status,
        hasMore,
        requestsApproved,
        requestsPending,
        requestsRejected,
        requestsSent,
        requestsWaitingPayment,
      ];
}

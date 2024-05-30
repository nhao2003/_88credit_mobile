part of 'request_bloc.dart';

enum RequestFetchStatus { loading, success, failure }

final class RequestState extends Equatable {
  final RequestFetchStatus status;
  final bool hasMoreSent;
  final List<LoanRequestEntity> sentRequestsApproved;
  final List<LoanRequestEntity> sentRequestsPending;
  final List<LoanRequestEntity> sentRequestsRejected;
  final List<LoanRequestEntity> sentRequestsSent;
  final List<LoanRequestEntity> sentRequestsWaitingPayment;

  final bool hasMoreReceived;
  final List<LoanRequestEntity> receivedRequestsApproved;
  final List<LoanRequestEntity> receivedRequestsPending;
  final List<LoanRequestEntity> receivedRequestsRejected;
  final List<LoanRequestEntity> receivedRequestsSent;
  final List<LoanRequestEntity> receivedRequestsWaitingPayment;

  const RequestState({
    this.status = RequestFetchStatus.loading,
    this.hasMoreSent = true,
    this.sentRequestsApproved = const [],
    this.sentRequestsPending = const [],
    this.sentRequestsRejected = const [],
    this.sentRequestsSent = const [],
    this.sentRequestsWaitingPayment = const [],
    this.hasMoreReceived = true,
    this.receivedRequestsApproved = const [],
    this.receivedRequestsPending = const [],
    this.receivedRequestsRejected = const [],
    this.receivedRequestsSent = const [],
    this.receivedRequestsWaitingPayment = const [],
  });

  RequestState copyWith({
    RequestFetchStatus? status,
    bool? hasMoreSent,
    List<LoanRequestEntity>? sentRequestsApproved,
    List<LoanRequestEntity>? sentRequestsPending,
    List<LoanRequestEntity>? sentRequestsRejected,
    List<LoanRequestEntity>? sentRequestsSent,
    List<LoanRequestEntity>? sentRequestsWaitingPayment,
    bool? hasMoreReceived,
    List<LoanRequestEntity>? receivedRequestsApproved,
    List<LoanRequestEntity>? receivedRequestsPending,
    List<LoanRequestEntity>? receivedRequestsRejected,
    List<LoanRequestEntity>? receivedRequestsSent,
    List<LoanRequestEntity>? receivedRequestsWaitingPayment,
  }) {
    return RequestState(
      status: status ?? this.status,
      hasMoreSent: hasMoreSent ?? this.hasMoreSent,
      sentRequestsApproved: sentRequestsApproved ?? this.sentRequestsApproved,
      sentRequestsPending: sentRequestsPending ?? this.sentRequestsPending,
      sentRequestsRejected: sentRequestsRejected ?? this.sentRequestsRejected,
      sentRequestsSent: sentRequestsSent ?? this.sentRequestsSent,
      sentRequestsWaitingPayment:
          sentRequestsWaitingPayment ?? this.sentRequestsWaitingPayment,
      hasMoreReceived: hasMoreReceived ?? this.hasMoreReceived,
      receivedRequestsApproved:
          receivedRequestsApproved ?? this.receivedRequestsApproved,
      receivedRequestsPending:
          receivedRequestsPending ?? this.receivedRequestsPending,
      receivedRequestsRejected:
          receivedRequestsRejected ?? this.receivedRequestsRejected,
      receivedRequestsSent: receivedRequestsSent ?? this.receivedRequestsSent,
      receivedRequestsWaitingPayment:
          receivedRequestsWaitingPayment ?? this.receivedRequestsWaitingPayment,
    );
  }

  @override
  List<Object> get props => [
        status,
        hasMoreSent,
        sentRequestsApproved,
        sentRequestsPending,
        sentRequestsRejected,
        sentRequestsSent,
        sentRequestsWaitingPayment,
        hasMoreReceived,
        receivedRequestsApproved,
        receivedRequestsPending,
        receivedRequestsRejected,
        receivedRequestsSent,
        receivedRequestsWaitingPayment,
      ];
}

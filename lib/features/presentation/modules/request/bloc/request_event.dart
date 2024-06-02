part of 'request_bloc.dart';

sealed class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

final class RefreshRequestEvent extends RequestEvent {
  final RequestTypes requestType;
  final LoanContractRequestStatus requestStatusType;

  const RefreshRequestEvent(this.requestType, this.requestStatusType);

  @override
  List<Object> get props => [requestType, requestStatusType];
}

final class FetchMoreRequestEvent extends RequestEvent {
  final RequestTypes requestType;
  final LoanContractRequestStatus requestStatusType;

  const FetchMoreRequestEvent(this.requestType, this.requestStatusType);

  @override
  List<Object> get props => [requestType, requestStatusType];
}

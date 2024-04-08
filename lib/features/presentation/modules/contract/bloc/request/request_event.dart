part of 'request_bloc.dart';

sealed class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

enum RequestStatusTypes { approved, pending, rejected, sent, waitingPayment }

final class RefreshRequestEvent extends RequestEvent {
  final RequestStatusTypes requestStatusType;

  const RefreshRequestEvent(this.requestStatusType);

  @override
  List<Object> get props => [requestStatusType];
}

final class FetchMoreRequestEvent extends RequestEvent {
  final RequestStatusTypes requestStatusType;

  const FetchMoreRequestEvent(this.requestStatusType);

  @override
  List<Object> get props => [requestStatusType];
}

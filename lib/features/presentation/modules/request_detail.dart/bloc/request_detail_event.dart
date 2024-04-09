part of 'request_detail_bloc.dart';

sealed class RequestDetailEvent extends Equatable {
  const RequestDetailEvent();

  @override
  List<Object> get props => [];
}

class RejectRequest extends RequestDetailEvent {
  final String reason;
  final LoanRequestEntity request;

  const RejectRequest(this.reason, this.request);

  @override
  List<Object> get props => [reason, request];
}

class ConfirmRequest extends RequestDetailEvent {
  final LoanRequestEntity request;

  const ConfirmRequest(this.request);

  @override
  List<Object> get props => [request];
}

class ReviewContract extends RequestDetailEvent {
  final LoanRequestEntity request;

  const ReviewContract(this.request);

  @override
  List<Object> get props => [request];
}

class ChangeRequestStatus extends RequestDetailEvent {
  final LoanContractRequestStatus status;

  const ChangeRequestStatus(this.status);

  @override
  List<Object> get props => [status];
}

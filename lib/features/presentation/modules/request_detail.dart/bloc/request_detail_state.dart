part of 'request_detail_bloc.dart';

enum CancelStatus { initial, loading, success, failure }

enum RejectStatus { initial, loading, success, failure }

enum ConfirmStatus { initial, loading, success, failure }

enum PaymentStatus { initial, loading, success, failure }

enum MarkPaidStatus { initial, loading, success, failure }

final class RequestDetailState extends Equatable {
  final ContractEntity contract;
  final CancelStatus cancelStatus;
  final RejectStatus rejectStatus;
  final ConfirmStatus confirmStatus;
  final PaymentStatus paymentStatus;
  final MarkPaidStatus markPaidStatus;
  final LoanContractRequestStatus requestStatus;
  final String failureMessage;

  const RequestDetailState({
    this.contract = const ContractEntity(),
    this.cancelStatus = CancelStatus.initial,
    this.rejectStatus = RejectStatus.initial,
    this.confirmStatus = ConfirmStatus.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.markPaidStatus = MarkPaidStatus.initial,
    this.requestStatus = LoanContractRequestStatus.pending,
    this.failureMessage = '',
  });

  RequestDetailState copyWith({
    ContractEntity? contract,
    CancelStatus? cancelStatus,
    RejectStatus? rejectStatus,
    ConfirmStatus? confirmStatus,
    PaymentStatus? paymentStatus,
    MarkPaidStatus? markPaidStatus,
    LoanContractRequestStatus? requestStatus,
    String? failureMessage,
  }) {
    return RequestDetailState(
      contract: contract ?? this.contract,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      rejectStatus: rejectStatus ?? this.rejectStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      requestStatus: requestStatus ?? this.requestStatus,
      markPaidStatus: markPaidStatus ?? this.markPaidStatus,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [
        contract,
        cancelStatus,
        rejectStatus,
        confirmStatus,
        paymentStatus,
        requestStatus,
        markPaidStatus,
        failureMessage,
      ];
}

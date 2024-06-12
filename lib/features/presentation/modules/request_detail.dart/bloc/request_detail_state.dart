part of 'request_detail_bloc.dart';

enum CancelStatus { initial, loading, success, failure }

enum RejectStatus { initial, loading, success, failure }

enum ConfirmStatus { initial, loading, success, failure }

enum PaymentStatus { initial, loading, success, failure }

final class RequestDetailState extends Equatable {
  final ContractEntity contract;
  final CancelStatus cancelStatus;
  final RejectStatus rejectStatus;
  final ConfirmStatus confirmStatus;
  final PaymentStatus paymentStatus;
  final LoanContractRequestStatus requestStatus;

  const RequestDetailState({
    this.contract = const ContractEntity(),
    this.cancelStatus = CancelStatus.initial,
    this.rejectStatus = RejectStatus.initial,
    this.confirmStatus = ConfirmStatus.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.requestStatus = LoanContractRequestStatus.pending,
  });

  RequestDetailState copyWith({
    ContractEntity? contract,
    CancelStatus? cancelStatus,
    RejectStatus? rejectStatus,
    ConfirmStatus? confirmStatus,
    PaymentStatus? paymentStatus,
    LoanContractRequestStatus? requestStatus,
  }) {
    return RequestDetailState(
      contract: contract ?? this.contract,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      rejectStatus: rejectStatus ?? this.rejectStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      requestStatus: requestStatus ?? this.requestStatus,
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
      ];
}

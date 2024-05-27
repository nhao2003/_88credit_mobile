part of 'request_detail_bloc.dart';

enum RejectStatus { initial, loading, success, failure }

enum ConfirmStatus { initial, loading, success, failure }

enum PaymentStatus { initial, loading, success, failure }

final class RequestDetailState extends Equatable {
  final ContractEntity contract;
  final RejectStatus rejectStatus;
  final ConfirmStatus confirmStatus;
  final PaymentStatus paymentStatus;
  final LoanContractRequestStatus requestStatus;

  const RequestDetailState({
    this.contract = const ContractEntity(),
    this.rejectStatus = RejectStatus.initial,
    this.confirmStatus = ConfirmStatus.initial,
    this.paymentStatus = PaymentStatus.initial,
    this.requestStatus = LoanContractRequestStatus.PENDING,
  });

  RequestDetailState copyWith({
    ContractEntity? contract,
    RejectStatus? rejectStatus,
    ConfirmStatus? confirmStatus,
    PaymentStatus? paymentStatus,
    LoanContractRequestStatus? requestStatus,
  }) {
    return RequestDetailState(
      contract: contract ?? this.contract,
      rejectStatus: rejectStatus ?? this.rejectStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  @override
  List<Object> get props => [
        contract,
        rejectStatus,
        confirmStatus,
        paymentStatus,
        requestStatus,
      ];
}

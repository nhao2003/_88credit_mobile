part of 'contract_detail_bloc.dart';

enum InitPDFStatus { initial, loading, success, failure }

final class ContractDetailState extends Equatable {
  final InitPDFStatus initPDFStatus;
  const ContractDetailState({
    this.initPDFStatus = InitPDFStatus.initial,
  });

  ContractDetailState copyWith({
    InitPDFStatus? initPDFStatus,
  }) {
    return ContractDetailState(
      initPDFStatus: initPDFStatus ?? this.initPDFStatus,
    );
  }

  @override
  List<Object> get props => [
        initPDFStatus,
      ];
}

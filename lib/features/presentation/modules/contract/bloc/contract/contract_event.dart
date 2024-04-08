part of 'contract_bloc.dart';

sealed class ContractEvent extends Equatable {
  const ContractEvent();

  @override
  List<Object> get props => [];
}

final class RefreshContractEvent extends ContractEvent {
  final PostTypes contractType;

  const RefreshContractEvent(this.contractType);

  @override
  List<Object> get props => [contractType];
}

final class FetchMoreContractEvent extends ContractEvent {
  final PostTypes contractType;

  const FetchMoreContractEvent(this.contractType);

  @override
  List<Object> get props => [contractType];
}

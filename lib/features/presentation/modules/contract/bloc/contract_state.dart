part of 'contract_bloc.dart';

enum ContractFetchStatus { loading, success, failure }

final class ContractState extends Equatable {
  final ContractFetchStatus status;
  final bool hasMore;
  final List<ContractEntity> lendingContracts;
  final List<ContractEntity> borrowingContracts;

  const ContractState({
    this.status = ContractFetchStatus.loading,
    this.hasMore = true,
    this.lendingContracts = const [],
    this.borrowingContracts = const [],
  });

  ContractState copyWith({
    ContractFetchStatus? status,
    bool? hasMore,
    List<ContractEntity>? lendingContracts,
    List<ContractEntity>? borrowingContracts,
  }) {
    return ContractState(
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      lendingContracts: lendingContracts ?? this.lendingContracts,
      borrowingContracts: borrowingContracts ?? this.borrowingContracts,
    );
  }

  @override
  List<Object> get props => [
        status,
        hasMore,
        lendingContracts,
        borrowingContracts,
      ];
}

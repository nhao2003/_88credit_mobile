part of 'contract_bloc.dart';

sealed class ContractState extends Equatable {
  const ContractState();
  
  @override
  List<Object> get props => [];
}

final class ContractInitial extends ContractState {}

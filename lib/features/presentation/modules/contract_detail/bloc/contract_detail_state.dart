part of 'contract_detail_bloc.dart';

sealed class ContractDetailState extends Equatable {
  const ContractDetailState();
  
  @override
  List<Object> get props => [];
}

final class ContractDetailInitial extends ContractDetailState {}

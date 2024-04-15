part of 'contract_detail_bloc.dart';

sealed class ContractDetailEvent extends Equatable {
  const ContractDetailEvent();

  @override
  List<Object> get props => [];
}

class InitPDF extends ContractDetailEvent {
}
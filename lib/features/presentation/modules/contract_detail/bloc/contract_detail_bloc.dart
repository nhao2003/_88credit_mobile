import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contract_detail_event.dart';
part 'contract_detail_state.dart';

class ContractDetailBloc extends Bloc<ContractDetailEvent, ContractDetailState> {
  ContractDetailBloc() : super(ContractDetailInitial()) {
    on<ContractDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

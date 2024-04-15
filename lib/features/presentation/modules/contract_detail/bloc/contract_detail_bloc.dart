import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'contract_detail_event.dart';
part 'contract_detail_state.dart';

class ContractDetailBloc
    extends Bloc<ContractDetailEvent, ContractDetailState> {
  ContractDetailBloc() : super(const ContractDetailState()) {
    on<ContractDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

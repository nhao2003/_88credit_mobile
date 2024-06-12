import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/bank.dart';
import '../../../../domain/entities/bank_card.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankBloc() : super(const BankState()) {
    on<BankEvent>((event, emit) {});
  }
}

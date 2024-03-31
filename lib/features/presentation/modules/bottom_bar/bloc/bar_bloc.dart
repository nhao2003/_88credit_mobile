import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'bar_event.dart';
part 'bar_state.dart';

class BarBloc extends Bloc<BarEvent, BarState> {
  BarBloc() : super(const BarState()) {
    on<BarChangeTab>(_changeTabIndex);
  }

  void _changeTabIndex(
    BarChangeTab event,
    Emitter<BarState> emit,
  ) {
    emit(state.copyWith(index: event.index));
  }
}

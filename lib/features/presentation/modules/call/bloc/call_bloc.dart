import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(const CallState()) {
    on<CallEvent>((event, emit) {});
    on<ChangeUser>((event, emit) {
      emit(state.copyWith(
        currentUser: UserInfo(id: event.id, name: event.name),
      ));
    });
    on<ChangeCallID>((event, emit) {
      emit(state.copyWith(callID: event.callID));
    });
  }
}

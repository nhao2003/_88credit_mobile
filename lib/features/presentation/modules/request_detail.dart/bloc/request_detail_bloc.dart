import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_detail_event.dart';
part 'request_detail_state.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  RequestDetailBloc() : super(RequestDetailInitial()) {
    on<RequestDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

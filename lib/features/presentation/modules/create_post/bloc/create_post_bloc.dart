import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(const CreatePostState()) {
    on<CreatePostEvent>((event, emit) {});
    on<TogglePageEvent>((event, emit) {
      emit(state.copyWith(isLending: event.isLending));
    });
    on<SendPostEvent>((event, emit) {
      _isLoggedIn(event, emit);
    });
  }

  void _isLoggedIn(
    CreatePostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(state.copyWith(status: CreatePostStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: CreatePostStatus.success));
  }
}

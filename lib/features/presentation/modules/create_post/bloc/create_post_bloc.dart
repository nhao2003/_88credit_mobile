import 'dart:io';
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
    on<SendPostEvent>(_sendPost);
    on<CheckLengthPhoto>(checkLengthPhoto);
    on<AddFileImageEvent>(_addImageFile);
    on<RemoveFileImageEvent>(_removeImageFile);
  }

  void _sendPost(
    SendPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(state.copyWith(status: CreatePostStatus.loading));
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      print('title: ${event.title}');
      print('description: ${event.description}');
      emit(state.copyWith(status: CreatePostStatus.success));
    });
  }

  void checkLengthPhoto(
    CheckLengthPhoto event,
    Emitter<CreatePostState> emit,
  ) {
    int length = state.photo.length + state.imageUrlList.length;
    emit(state.copyWith(photoController: length >= 3 && length <= 12));
  }

  void _addImageFile(
    AddFileImageEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(photo: [...state.photo, event.file]));
  }

  void _removeImageFile(
    RemoveFileImageEvent event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.index < state.imageUrlList.length) {
      return emit(state.copyWith(
          imageUrlList: state.imageUrlList..removeAt(event.index)));
    }
    emit(state.copyWith(
        photo: state.photo..removeAt(event.index - state.imageUrlList.length)));
  }
}

import 'dart:io';
import 'package:_88credit_mobile/features/domain/entities/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/usecases/media/upload_images.dart';
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
    on<ChangeLoanReasonEvent>(changeLoanReason);
  }

  void _sendPost(
    SendPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(state.copyWith(status: CreatePostStatus.loading));
    // upload images
    List<String> images = await _uploadImages();
    // create post entity
    PostEntity postEntity = createPostEntity(event, images);
    // send post
    print(postEntity.toString());
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
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

  void changeLoanReason(
    ChangeLoanReasonEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(loanReasonType: event.loanReason));
  }

  Future<List<String>> _uploadImages() async {
    UploadImagesUseCase uploadImagessUseCase = sl<UploadImagesUseCase>();
    if (state.photo.isEmpty) {
      return [];
    }
    final dataState = await uploadImagessUseCase(params: state.photo);
    if (dataState is DataSuccess) {
      return dataState.data!;
    } else {
      return [];
    }
  }

  PostEntity createPostEntity(SendPostEvent event, List<String> images) {
    try {
      if (state.isLending) {
        // Lending
        return PostEntity(
          isLease: state.isLending,
          title: event.title!,
          description: event.description!,
          images: images,
          amount: event.amount!,
          maxAmount: event.maxAmount!,
          interestRate: event.interestRate!,
          maxInterestRate: event.maxInterestRate!,
          duration: event.duration!,
          maxDuration: event.maxDuration!,
          overdueInterestRate: event.overdueInterestRate!,
          maxOverdueInterestRate: event.maxOverdueInterestRate!,
        );
      } else {
        return PostEntity(
          isLease: state.isLending,
          title: event.title!,
          description: event.description!,
          images: images,
          amount: event.amount!,
          interestRate: event.interestRate!,
          overdueInterestRate: event.overdueInterestRate!,
          duration: event.duration!,
          loanReason: state.loanReasonType,
          loanReasonDescription: event.loanReasonDescription!,
        );
      }
    } catch (e) {
      print("Error when Create Post: $e");
      return const PostEntity();
    }
  }
}

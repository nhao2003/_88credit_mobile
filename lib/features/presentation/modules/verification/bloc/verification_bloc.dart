import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/enums/type_indetification_document.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(const VerificationState()) {
    on<VerificationEvent>((event, emit) {});
    on<ChangeStepEvent>((event, emit) {
      emit(state.copyWith(activeStep: event.step));
    });
    on<ChangeSelectedRadio>((event, emit) {
      emit(state.copyWith(selectedRadio: event.selectedRadio));
    });
    on<ChangeTypeIndetificationDocument>((event, emit) {
      emit(state.copyWith(typeIndetificationDocument: event.type));
    });

    on<ChangeIssueBy>((event, emit) {
      emit(state.copyWith(issuedBy: event.issuedBy));
    });

    on<ChangeGender>((event, emit) {
      emit(state.copyWith(isMale: event.isMale));
    });

    on<ChangeApprove>((event, emit) {
      emit(state.copyWith(isApprove: event.isApprove));
    });

    on<UploadImageFile>((event, emit) {
      if (event.typeImage) {
        emit(state.copyWith(
          urlImageCardFront: event.file.path,
          uploadCardStatus: UploadCardStatus.success,
        ));
      } else {
        emit(state.copyWith(
          urlImageCardBack: event.file.path,
          uploadCardStatus: UploadCardStatus.success,
        ));
      }
    });

    on<UploadPortrait>((event, emit) {
      emit(state.copyWith(
        urlImagePortrait: event.file.path,
        uploadPortraitstatus: UploadPortraitstatus.success,
      ));
    });
  }
}

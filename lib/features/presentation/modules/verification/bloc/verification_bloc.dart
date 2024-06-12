import 'dart:io';

import 'package:_88credit_mobile/core/resources/data_state.dart';
import 'package:_88credit_mobile/core/resources/pair.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/init_request_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/send_ocr_back_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/send_ocr_front_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
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

    on<UploadImageFile>(_handleUploadImageFile);

    on<UploadPortrait>((event, emit) {
      emit(state.copyWith(
        urlImagePortrait: event.file.path,
        uploadPortraitstatus: UploadPortraitstatus.success,
      ));
    });

    on<InitEkycEvent>(_initEkyc);
  }

  Future _initEkyc(InitEkycEvent event, Emitter<VerificationState> emit) async {
    emit(state.copyWith(initEkycStatus: InitEkycStatus.loading));
    InitRequestUseCase initRequestUseCase = sl<InitRequestUseCase>();
    final result = await initRequestUseCase();

    if (result is DataSuccess) {
      print("Request id: ${result.data}");
      emit(state.copyWith(
        initEkycStatus: InitEkycStatus.success,
        requestId: result.data,
      ));
    } else {
      emit(state.copyWith(initEkycStatus: InitEkycStatus.failure));
    }
  }

  Future _handleUploadImageFile(
      UploadImageFile event, Emitter<VerificationState> emit) async {
    if (event.typeImage) {
      emit(state.copyWith(
        urlImageCardFront: event.file.path,
        uploadCardStatus: UploadCardStatus.loading,
      ));
      // upload image
      print("Request id: ${state.requestId}");
      print("File path: ${event.file.path}");
      SendOcrFrontUseCase sendOcrFrontUseCase = sl<SendOcrFrontUseCase>();
      final result =
          await sendOcrFrontUseCase(params: Pair(state.requestId, event.file));

      if (result is DataSuccess) {
        emit(state.copyWith(
          uploadCardStatus: UploadCardStatus.success,
        ));
      } else {
        emit(state.copyWith(
          uploadCardStatus: UploadCardStatus.failure,
        ));
      }
    } else {
      emit(state.copyWith(
        urlImageCardBack: event.file.path,
        uploadCardStatus: UploadCardStatus.loading,
      ));

      // upload image
      print("Request id: ${state.requestId}");
      print("File path: ${event.file.path}");
      SendOcrBackUseCase sendOcrBackUseCase = sl<SendOcrBackUseCase>();
      final result =
          await sendOcrBackUseCase(params: Pair(state.requestId, event.file));

      if (result is DataSuccess) {
        emit(state.copyWith(
          uploadCardStatus: UploadCardStatus.success,
        ));
      } else {
        emit(state.copyWith(
          uploadCardStatus: UploadCardStatus.failure,
        ));
      }
    }
  }
}

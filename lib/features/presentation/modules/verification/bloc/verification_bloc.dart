import 'dart:io';

import 'package:_88credit_mobile/core/resources/data_state.dart';
import 'package:_88credit_mobile/core/resources/pair.dart';
import 'package:_88credit_mobile/features/data/models/front_card_info.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/init_request_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/send_face_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/send_ocr_back_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/send_ocr_front_usecase.dart';
import 'package:_88credit_mobile/features/domain/usecases/ekyc/submit_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
import '../../../../data/models/back_card_info.dart';
import '../../../../domain/enums/type_indetification_document.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(const VerificationState()) {
    on<VerificationEvent>((event, emit) {});
    on<InitStateEvent>((event, emit) {
      emit(state.copyWith(
        initEkycStatus: InitEkycStatus.init,
        uploadCardFrontStatus: UploadCardFrontStatus.init,
        uploadCardBackStatus: UploadCardBackStatus.init,
        uploadPortraitstatus: UploadPortraitstatus.init,
        uploadInfoStatus: UploadInfoStatus.init,
        requestId: "",
        frontCardInfo: const FrontCardInfo(),
        backCardInfo: const BackCardInfo(),
        activeStep: 0,
        selectedRadio: 0,
        urlImageCardFront: "",
        urlImageCardBack: "",
        isUploadCardFront: false,
        isUploadCardBack: false,
        urlImagePortrait: "",
        typeIndetificationDocument: TypeIndetificationDocument.canCuocCongDan,
        issuedBy: "",
        isMale: true,
        isApprove: false,
      ));
    });
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

    on<UploadFrontCardFile>(_handleFrontCardFile);

    on<UploadBackCardFile>(_handleBackCardFile);

    on<UploadPortrait>(_handleUploadPortrail);

    on<InitEkycEvent>(_initEkyc);

    on<SubmitEkyc>(_submit);
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

  Future _handleFrontCardFile(
      UploadFrontCardFile event, Emitter<VerificationState> emit) async {
    emit(state.copyWith(
      urlImageCardFront: event.file.path,
      uploadCardFrontStatus: UploadCardFrontStatus.loading,
    ));
    // upload image
    print("Request id: ${state.requestId}");
    print("File path: ${event.file.path}");
    SendOcrFrontUseCase sendOcrFrontUseCase = sl<SendOcrFrontUseCase>();
    final result =
        await sendOcrFrontUseCase(params: Pair(state.requestId, event.file));

    if (result is DataSuccess) {
      emit(state.copyWith(
        uploadCardFrontStatus: UploadCardFrontStatus.success,
        frontCardInfo: result.data,
      ));
    } else {
      emit(state.copyWith(
        uploadCardFrontStatus: UploadCardFrontStatus.failure,
      ));
    }
  }

  Future _handleBackCardFile(
      UploadBackCardFile event, Emitter<VerificationState> emit) async {
    emit(state.copyWith(
      urlImageCardBack: event.file.path,
      uploadCardBackStatus: UploadCardBackStatus.loading,
    ));
    // upload image
    print("Request id: ${state.requestId}");
    print("File path: ${event.file.path}");
    SendOcrBackUseCase sendOcrBackUseCase = sl<SendOcrBackUseCase>();
    final result =
        await sendOcrBackUseCase(params: Pair(state.requestId, event.file));

    if (result is DataSuccess) {
      emit(state.copyWith(
        uploadCardBackStatus: UploadCardBackStatus.success,
        backCardInfo: result.data,
      ));
    } else {
      emit(state.copyWith(
        uploadCardBackStatus: UploadCardBackStatus.failure,
      ));
    }
  }

  Future _handleUploadPortrail(
      UploadPortrait event, Emitter<VerificationState> emit) async {
    emit(state.copyWith(
      urlImagePortrait: event.file.path,
      uploadPortraitstatus: UploadPortraitstatus.loading,
    ));
    // upload image
    print("Request id: ${state.requestId}");
    print("File path: ${event.file.path}");
    SendFaceUseCase sendFaceUseCase = sl<SendFaceUseCase>();
    final result =
        await sendFaceUseCase(params: Pair(state.requestId, event.file));

    if (result is DataSuccess) {
      emit(state.copyWith(
        uploadPortraitstatus: UploadPortraitstatus.success,
      ));
    } else {
      emit(state.copyWith(
        uploadPortraitstatus: UploadPortraitstatus.failure,
      ));
    }
  }

  Future _submit(SubmitEkyc event, Emitter<VerificationState> emit) async {
    emit(state.copyWith(submtiStatus: SubmtiStatus.loading));

    try {
      // submit
      SubmitUseCase submitUseCase = sl<SubmitUseCase>();
      final result = await submitUseCase(params: state.requestId);

      if (result is DataSuccess) {
        emit(state.copyWith(submtiStatus: SubmtiStatus.success));
      } else {
        emit(state.copyWith(
            submtiStatus: SubmtiStatus.failure,
            failureMessage: result.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
        submtiStatus: SubmtiStatus.failure,
        failureMessage: e.toString(),
      ));
    }
  }
}

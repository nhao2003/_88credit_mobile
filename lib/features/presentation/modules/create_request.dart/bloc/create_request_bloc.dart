import 'dart:io';
import 'package:_88credit_mobile/features/domain/entities/bank_card.dart';
import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/loan_request.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';
import '../../../../domain/usecases/bank/get_primary_bank_card.dart';
import '../../../../domain/usecases/contract/create_loan_request.dart';
import '../../../../domain/usecases/media/upload_file.dart';

part 'create_request_event.dart';
part 'create_request_state.dart';

class CreateRequestBloc extends Bloc<CreateRequestEvent, CreateRequestState> {
  CreateRequestBloc() : super(const CreateRequestState()) {
    on<CreateRequestEvent>((event, emit) {});
    on<SendRequestEvent>(_sendRequest);
    on<ChangeCreateRequestStatus>((event, emit) {
      emit(state.copyWith(status: event.status));
    });
    on<ChangeReceiver>((event, emit) {
      emit(state.copyWith(receiver: event.receiver));
    });
    on<GetPrimaryBankCard>(onGetPrimaryBankCard);
    on<PostRequest>((event, emit) {});
    on<ChangePortrait>((event, emit) {
      emit(state.copyWith(portrait: () => event.portrait));
    });
    on<ChangeIdCardFrontPhoto>((event, emit) {
      emit(state.copyWith(idCardFrontPhoto: () => event.idCardFrontPhoto));
    });
    on<ChangeIdCardBackPhoto>((event, emit) {
      emit(state.copyWith(idCardBackPhoto: () => event.idCardBackPhoto));
    });
    on<ChangeVideo>((event, emit) {
      emit(state.copyWith(video: () => event.video));
    });
    on<ChangeLoanReasonEvent>((event, emit) {
      emit(state.copyWith(loanReasonType: event.loanReasonType));
    });
  }

  UserEntity receiverDefault = UserEntity(
    id: "2f434eae-7b6d-4b5e-8c09-38f315173743",
    status: UserStatus.verified,
    isIdentityVerified: true,
    role: Role.user,
    email: "user3@example.com",
    address: null,
    firstName: "Alex",
    lastName: "Johnson",
    gender: false,
    avatar: "https://picsum.photos/200/300?random=4",
    dob: null,
    phone: "123456789",
    lastActiveAt: DateTime.parse("2023-12-06T01:53:30.033Z"),
    createdAt: DateTime.parse("2023-12-06T01:53:30.033Z"),
    updatedAt: null,
    bannedUtil: null,
    banReason: null,
  );

  void _sendRequest(
    SendRequestEvent event,
    Emitter<CreateRequestState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateRequestStatus.loading));

      CreateRequestsUseCase createRequestUseCase = sl<CreateRequestsUseCase>();
      final listMedia = await uploadImages();
      final request = getNewRequest(event, listMedia, state.primaryBankCard);
      final dataState = await createRequestUseCase(params: request);

      if (dataState is DataSuccess) {
        emit(state.copyWith(status: CreateRequestStatus.success));
      } else {
        emit(state.copyWith(
            status: CreateRequestStatus.failure,
            failureString: dataState.error.toString()));
      }
    } catch (e) {
      emit(state.copyWith(
          status: CreateRequestStatus.failure, failureString: e.toString()));
    }
  }

  Future<void> onGetPrimaryBankCard(
      GetPrimaryBankCard event, Emitter<CreateRequestState> emit) async {
    emit(state.copyWith(
        getPrimaryBankCardStatus: GetPrimaryBankCardStatus.loading));
    try {
      final primaryBankCard = await getPrimaryBankCard();
      emit(state.copyWith(
        primaryBankCard: primaryBankCard,
        getPrimaryBankCardStatus: GetPrimaryBankCardStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          getPrimaryBankCardStatus: GetPrimaryBankCardStatus.failure));
    }
  }

  GetPrimaryBankCardUseCase getPrimaryBankCardUseCase =
      sl<GetPrimaryBankCardUseCase>();
  Future<BankCardEntity> getPrimaryBankCard() async {
    final dataState = await getPrimaryBankCardUseCase();
    if (dataState == null) {
      throw Exception("Primary bank card not found");
    }
    return dataState;
  }

  Future<List<String>> uploadImages() async {
    UploadFileUseCase uploadUsecase = sl<UploadFileUseCase>();
    // check null
    if (state.portrait == null ||
        state.idCardFrontPhoto == null ||
        state.idCardBackPhoto == null ||
        state.video == null) {
      throw Exception("Some images are null");
    }
    List responses = await Future.wait([
      uploadUsecase(params: Pair(state.portrait!, "request")),
      uploadUsecase(params: Pair(state.idCardFrontPhoto!, "request")),
      uploadUsecase(params: Pair(state.idCardBackPhoto!, "request")),
      uploadUsecase(params: Pair(state.video!, "request")),
    ]);
    List<String> urls = [];
    // if each response is success, return list of urls
    for (var response in responses) {
      if (response is DataSuccess) {
        urls.add(response.data!);
      }
    }
    // urls.add(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
    // // List<String> urls = [
    // //   "https://res.cloudinary.com/devfdx8fs/image/upload/v1718199726/request/qu9kaniipj5ywejdkjow.jpg",
    // //   "https://res.cloudinary.com/devfdx8fs/image/upload/v1718199726/request/qu9kaniipj5ywejdkjow.jpg",
    // //   "https://res.cloudinary.com/devfdx8fs/image/upload/v1718199726/request/qu9kaniipj5ywejdkjow.jpg",
    // //   "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    // // ];

    return urls;
  }

  LoanRequestEntity getNewRequest(SendRequestEvent event,
      List<dynamic> listMedia, BankCardEntity senderPrimaryBankCard) {
    String portraitUrl = listMedia[0];
    String idCardFrontPhotoUrl = listMedia[1];
    String idCardBackPhotoUrl = listMedia[2];
    String videoUrl = listMedia[3];

    final request = LoanRequestEntity(
      receiverId: receiverDefault.id,
      receiver: receiverDefault,
      description: event.description,
      loanAmount: event.loanAmount,
      interestRate: event.interestRate,
      overdueInterestRate: event.overdueInterestRate,
      loanTenureMonths: event.loanTenureMonths,
      loanReasonType: state.loanReasonType,
      loanReason: event.loanReason,
      videoConfirmationUrl: videoUrl,
      portaitPhotoUrl: portraitUrl,
      idCardFrontPhotoUrl: idCardFrontPhotoUrl,
      idCardBackPhotoUrl: idCardBackPhotoUrl,
      senderBankCardId: senderPrimaryBankCard.id,
    );
    return request;
  }
}

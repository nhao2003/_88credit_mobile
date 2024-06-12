import 'dart:io';
import 'package:_88credit_mobile/features/domain/entities/bank_card.dart';
import 'package:_88credit_mobile/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/loan_request.dart';
import '../../../../domain/enums/loan_reason_types.dart';
import '../../../../domain/enums/role.dart';
import '../../../../domain/enums/user_status.dart';
import '../../../../domain/usecases/bank/get_primary_bank_card.dart';

part 'create_request_event.dart';
part 'create_request_state.dart';

class CreateRequestBloc extends Bloc<CreateRequestEvent, CreateRequestState> {
  CreateRequestBloc() : super(const CreateRequestState()) {
    on<CreateRequestEvent>((event, emit) {});
    on<SendRequestEvent>(_sendRequest);
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
    id: "7c90e199-d3c7-4b50-8b08-7f8c40ab5412",
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
    final senderPrimaryBankCard = await getPrimaryBankCard();
    final listMedia = await uploadImages();
    getNewRequest(event, listMedia, senderPrimaryBankCard);
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

  Future<List<dynamic>> uploadImages() async {
    // List responses = await Future.wait([
    //   uploadImages(portrait.value!),
    //   uploadImages(idCardFrontPhoto.value!),
    //   uploadImages(idCardBackPhoto.value!),
    //   uploadVideos(video.value!),
    // ]);
    return [
      ["https://picsum.photos/200/300?random=1"],
      ["https://picsum.photos/200/300?random=2"],
      ["https://picsum.photos/200/300?random=3"],
      [
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
      ],
    ];
  }

  Future<LoanRequestEntity> getNewRequest(SendRequestEvent event,
      List<dynamic> listMedia, BankCardEntity senderPrimaryBankCard) async {
    String portraitUrl = listMedia[0][0];
    String idCardFrontPhotoUrl = listMedia[1][0];
    String idCardBackPhotoUrl = listMedia[2][0];
    String videoUrl = listMedia[3][0];

    final request = LoanRequestEntity(
      receiverId: receiverDefault.id,
      description: event.description,
      loanAmount: event.loanAmount,
      interestRate: event.interestRate,
      overdueInterestRate: event.overdueInterestRate,
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

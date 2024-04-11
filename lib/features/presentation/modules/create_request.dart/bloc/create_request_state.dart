part of 'create_request_bloc.dart';

enum GetPrimaryBankCardStatus { initial, loading, success, failure }

enum CreateRequestStatus { initial, loading, success, failure }

final class CreateRequestState extends Equatable {
  final UserEntity receiver;
  final GetPrimaryBankCardStatus getPrimaryBankCardStatus;
  final BankCardEntity primaryBankCard;
  final CreateRequestStatus createRequestStatus;

  final File? portrait;
  final File? idCardFrontPhoto;
  final File? idCardBackPhoto;
  final File? video;

  const CreateRequestState({
    this.receiver = const UserEntity(),
    this.getPrimaryBankCardStatus = GetPrimaryBankCardStatus.initial,
    this.primaryBankCard = const BankCardEntity(),
    this.createRequestStatus = CreateRequestStatus.initial,
    this.portrait,
    this.idCardFrontPhoto,
    this.idCardBackPhoto,
    this.video,
  });

  CreateRequestState copyWith({
    UserEntity? receiver,
    GetPrimaryBankCardStatus? getPrimaryBankCardStatus,
    BankCardEntity? primaryBankCard,
    CreateRequestStatus? status,
    File? portrait,
    File? idCardFrontPhoto,
    File? idCardBackPhoto,
    File? video,
  }) {
    return CreateRequestState(
      receiver: receiver ?? this.receiver,
      getPrimaryBankCardStatus:
          getPrimaryBankCardStatus ?? this.getPrimaryBankCardStatus,
      primaryBankCard: primaryBankCard ?? this.primaryBankCard,
      createRequestStatus: status ?? createRequestStatus,
      portrait: portrait ?? this.portrait,
      idCardFrontPhoto: idCardFrontPhoto ?? this.idCardFrontPhoto,
      idCardBackPhoto: idCardBackPhoto ?? this.idCardBackPhoto,
      video: video ?? this.video,
    );
  }

  @override
  List<Object?> get props => [
        receiver,
        getPrimaryBankCardStatus,
        primaryBankCard,
        createRequestStatus,
        portrait,
        idCardFrontPhoto,
        idCardBackPhoto,
        video,
      ];
}

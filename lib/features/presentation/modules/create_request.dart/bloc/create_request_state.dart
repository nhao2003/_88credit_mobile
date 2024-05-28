part of 'create_request_bloc.dart';

enum GetPrimaryBankCardStatus { initial, loading, success, failure }

enum CreateRequestStatus { initial, loading, success, failure }

final class CreateRequestState extends Equatable {
  final UserEntity receiver;
  final GetPrimaryBankCardStatus getPrimaryBankCardStatus;
  final BankCardEntity primaryBankCard;
  final CreateRequestStatus createRequestStatus;
  final LoanReasonTypes loanReasonType;

  final File? portrait;
  final File? idCardFrontPhoto;
  final File? idCardBackPhoto;
  final File? video;

  const CreateRequestState({
    this.receiver = const UserEntity(),
    this.getPrimaryBankCardStatus = GetPrimaryBankCardStatus.initial,
    this.primaryBankCard = const BankCardEntity(),
    this.createRequestStatus = CreateRequestStatus.initial,
    this.loanReasonType = LoanReasonTypes.BUSINESS,
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
    LoanReasonTypes? loanReasonType,
    ValueGetter<File?>? portrait,
    ValueGetter<File?>? idCardFrontPhoto,
    ValueGetter<File?>? idCardBackPhoto,
    ValueGetter<File?>? video,
  }) {
    return CreateRequestState(
      receiver: receiver ?? this.receiver,
      getPrimaryBankCardStatus:
          getPrimaryBankCardStatus ?? this.getPrimaryBankCardStatus,
      primaryBankCard: primaryBankCard ?? this.primaryBankCard,
      createRequestStatus: status ?? createRequestStatus,
      loanReasonType: loanReasonType ?? this.loanReasonType,
      portrait: portrait != null ? portrait() : this.portrait,
      idCardFrontPhoto:
          idCardFrontPhoto != null ? idCardFrontPhoto() : this.idCardFrontPhoto,
      idCardBackPhoto:
          idCardBackPhoto != null ? idCardBackPhoto() : this.idCardBackPhoto,
      video: video != null ? video() : this.video,
    );
  }

  @override
  List<Object?> get props => [
        receiver,
        getPrimaryBankCardStatus,
        primaryBankCard,
        createRequestStatus,
        loanReasonType,
        portrait,
        idCardFrontPhoto,
        idCardBackPhoto,
        video,
      ];
}

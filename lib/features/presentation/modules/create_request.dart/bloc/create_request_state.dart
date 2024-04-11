part of 'create_request_bloc.dart';

enum GetPrimaryBankCardStatus { initial, loading, success, failure }

enum CreateRequestStatus { initial, loading, success, failure }

final class CreateRequestState extends Equatable {
  final UserEntity receiver;
  final GetPrimaryBankCardStatus getPrimaryBankCardStatus;
  final BankCardEntity primaryBankCard;
  final CreateRequestStatus createRequestStatus;

  const CreateRequestState({
    this.receiver = const UserEntity(),
    this.getPrimaryBankCardStatus = GetPrimaryBankCardStatus.initial,
    this.primaryBankCard = const BankCardEntity(),
    this.createRequestStatus = CreateRequestStatus.initial,
  });

  CreateRequestState copyWith({
    UserEntity? receiver,
    GetPrimaryBankCardStatus? getPrimaryBankCardStatus,
    BankCardEntity? primaryBankCard,
    CreateRequestStatus? status,
  }) {
    return CreateRequestState(
      receiver: receiver ?? this.receiver,
      getPrimaryBankCardStatus:
          getPrimaryBankCardStatus ?? this.getPrimaryBankCardStatus,
      primaryBankCard: primaryBankCard ?? this.primaryBankCard,
      createRequestStatus: status ?? createRequestStatus,
    );
  }

  @override
  List<Object> get props => [
        receiver,
        getPrimaryBankCardStatus,
        primaryBankCard,
        createRequestStatus,
      ];
}

part of 'create_request_bloc.dart';

enum GetPrimaryBankCardStatus { initial, loading, success, failure }

final class CreateRequestState extends Equatable {
  final UserEntity receiver;
  final GetPrimaryBankCardStatus getPrimaryBankCardStatus;
  final BankCardEntity primaryBankCard;

  const CreateRequestState({
    this.receiver = const UserEntity(),
    this.getPrimaryBankCardStatus = GetPrimaryBankCardStatus.initial,
    this.primaryBankCard = const BankCardEntity(),
  });

  CreateRequestState copyWith({
    UserEntity? receiver,
    GetPrimaryBankCardStatus? getPrimaryBankCardStatus,
    BankCardEntity? primaryBankCard,
  }) {
    return CreateRequestState(
      receiver: receiver ?? this.receiver,
      getPrimaryBankCardStatus:
          getPrimaryBankCardStatus ?? this.getPrimaryBankCardStatus,
      primaryBankCard: primaryBankCard ?? this.primaryBankCard,
    );
  }

  @override
  List<Object> get props => [
        receiver,
        getPrimaryBankCardStatus,
        primaryBankCard,
      ];
}

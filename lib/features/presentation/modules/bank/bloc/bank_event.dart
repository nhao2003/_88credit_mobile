part of 'bank_bloc.dart';

sealed class BankEvent extends Equatable {
  const BankEvent();

  @override
  List<Object> get props => [];
}

class GetBankCard extends BankEvent {}

class SearchBank extends BankEvent {
  final String value;
  final int page;

  const SearchBank(this.value, this.page);

  @override
  List<Object> get props => [value, page];
}

class MarkAsPrimaryCard extends BankEvent {
  final String idCard;

  const MarkAsPrimaryCard(this.idCard);

  @override
  List<Object> get props => [idCard];
}

class ChangeSelectedBank extends BankEvent {
  final BankEntity bank;

  const ChangeSelectedBank(this.bank);

  @override
  List<Object> get props => [bank];
}

class AddBankCard extends BankEvent {
  final String cardNumber;

  const AddBankCard(this.cardNumber);

  @override
  List<Object> get props => [cardNumber];
}

class DeleteBankCard extends BankEvent {
  final String idCard;

  const DeleteBankCard(this.idCard);

  @override
  List<Object> get props => [idCard];
}

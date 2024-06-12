part of 'bank_bloc.dart';

enum GetBankCardStatus { loading, success, error }

enum MarkAsPrimaryBankCardStatus { loading, success, error }

enum AddBankCardStatus { loading, success, error }

enum DeleteBankCardStatus { loading, success, error }

class BankState extends Equatable {
  final GetBankCardStatus getBankCardStatus;
  final List<BankCardEntity> listBankCards;
  final MarkAsPrimaryBankCardStatus markAsPrimaryBankCardStatus;
  final AddBankCardStatus addBankCardStatus;
  final BankEntity selectedBank;

  const BankState(
      {this.getBankCardStatus = GetBankCardStatus.loading,
      this.listBankCards = const [],
      this.markAsPrimaryBankCardStatus = MarkAsPrimaryBankCardStatus.loading,
      this.addBankCardStatus = AddBankCardStatus.loading,
      this.selectedBank = const BankEntity.empty()});

  BankState copyWith(
      {GetBankCardStatus? getBankCardStatus,
      List<BankCardEntity>? listBankCards,
      MarkAsPrimaryBankCardStatus? markAsPrimaryBankCardStatus,
      AddBankCardStatus? addBankCardStatus,
      BankEntity? selectedBank}) {
    return BankState(
      getBankCardStatus: getBankCardStatus ?? this.getBankCardStatus,
      listBankCards: listBankCards ?? this.listBankCards,
      markAsPrimaryBankCardStatus:
          markAsPrimaryBankCardStatus ?? this.markAsPrimaryBankCardStatus,
      addBankCardStatus: addBankCardStatus ?? this.addBankCardStatus,
      selectedBank: selectedBank ?? this.selectedBank,
    );
  }

  @override
  List<Object> get props => [
        getBankCardStatus,
        listBankCards,
        markAsPrimaryBankCardStatus,
        addBankCardStatus,
        selectedBank,
      ];
}

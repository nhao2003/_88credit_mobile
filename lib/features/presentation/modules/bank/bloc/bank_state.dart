part of 'bank_bloc.dart';

enum GetBankCardStatus { init, loading, success, error }

enum MarkAsPrimaryBankCardStatus { init, loading, success, error }

enum AddBankCardStatus { init, loading, success, error }

enum DeleteBankCardStatus { init, loading, success, error }

class BankState extends Equatable {
  final GetBankCardStatus getBankCardStatus;
  final List<BankCardEntity> listBankCards;
  final MarkAsPrimaryBankCardStatus markAsPrimaryBankCardStatus;
  final AddBankCardStatus addBankCardStatus;
  final DeleteBankCardStatus deleteBankCardStatus;
  final BankEntity selectedBank;

  const BankState(
      {this.getBankCardStatus = GetBankCardStatus.init,
      this.listBankCards = const [],
      this.markAsPrimaryBankCardStatus = MarkAsPrimaryBankCardStatus.init,
      this.addBankCardStatus = AddBankCardStatus.init,
      this.deleteBankCardStatus = DeleteBankCardStatus.init,
      this.selectedBank = const BankEntity.empty()});

  BankState copyWith(
      {GetBankCardStatus? getBankCardStatus,
      List<BankCardEntity>? listBankCards,
      MarkAsPrimaryBankCardStatus? markAsPrimaryBankCardStatus,
      AddBankCardStatus? addBankCardStatus,
      DeleteBankCardStatus? deleteBankCardStatus,
      BankEntity? selectedBank}) {
    return BankState(
      getBankCardStatus: getBankCardStatus ?? this.getBankCardStatus,
      listBankCards: listBankCards ?? this.listBankCards,
      markAsPrimaryBankCardStatus:
          markAsPrimaryBankCardStatus ?? this.markAsPrimaryBankCardStatus,
      addBankCardStatus: addBankCardStatus ?? this.addBankCardStatus,
      deleteBankCardStatus: deleteBankCardStatus ?? this.deleteBankCardStatus,
      selectedBank: selectedBank ?? this.selectedBank,
    );
  }

  @override
  List<Object> get props => [
        getBankCardStatus,
        listBankCards,
        markAsPrimaryBankCardStatus,
        addBankCardStatus,
        deleteBankCardStatus,
        selectedBank,
      ];
}

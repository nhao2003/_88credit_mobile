import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/bank.dart';
import '../entities/bank_card.dart';

abstract class BankRepository {
  Future<DataState<Pair<int, List<BankEntity>>>> searchBanks(
      String query, int page);

  Future<DataState<List<BankCardEntity>>> getBankCards();

  Future<DataState<void>> markAsPrimaryBankCard(String id);
  Future<DataState<void>> addBankCard(BankCardEntity bankCardEntity);
  Future<DataState<void>> deleteBankCard(BankCardEntity bankCardEntity);
  Future<DataState<BankCardEntity>> getPrimaryBankCard();
}

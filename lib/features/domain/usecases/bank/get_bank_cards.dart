import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/bank_card.dart';
import '../../repositories/bank_repository.dart';

class GetBankCardsUseCase implements UseCase<List<BankCardEntity>, void> {
  final BankRepository _bankRepository;

  GetBankCardsUseCase(this._bankRepository);

  @override
  Future<List<BankCardEntity>> call({void params}) async {
    return await _bankRepository.getBankCards().then((value) {
      if (value is DataSuccess) {
        return value.data ?? [];
      } else {
        return [];
      }
    });
  }
}

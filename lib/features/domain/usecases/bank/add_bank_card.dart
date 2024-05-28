import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/bank_card.dart';
import '../../repositories/bank_repository.dart';

class AddBankCardUseCase implements UseCase<DataState<void>, BankCardEntity> {
  final BankRepository _bankRepository;

  AddBankCardUseCase(this._bankRepository);

  @override
  Future<DataState<void>> call({BankCardEntity? params}) {
    return _bankRepository.addBankCard(params!);
  }
}

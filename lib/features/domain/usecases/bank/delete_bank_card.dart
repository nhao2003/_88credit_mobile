import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/bank_card.dart';
import '../../repositories/bank_repository.dart';

class DeleteBankCardUseCase
    implements UseCase<DataState<void>, BankCardEntity> {
  final BankRepository _bankRepository;

  DeleteBankCardUseCase(this._bankRepository);

  @override
  Future<DataState<void>> call({BankCardEntity? params}) {
    return _bankRepository.deleteBankCard(params!);
  }
}

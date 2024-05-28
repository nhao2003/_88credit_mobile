import '../../../../core/usecases/usecase.dart';
import '../../repositories/bank_repository.dart';

class MarkAsPrimaryBankCardsUseCase implements UseCase<void, String> {
  final BankRepository _bankRepository;

  MarkAsPrimaryBankCardsUseCase(this._bankRepository);

  @override
  Future<void> call({String? params}) async {
    await _bankRepository.markAsPrimaryBankCard(params!);
  }
}

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/bank.dart';
import '../../repositories/bank_repository.dart';

class GetAllbankUseCase
    implements UseCase<Pair<int, List<BankEntity>>, Pair<String, int>> {
  final BankRepository _bankRepository;

  GetAllbankUseCase(this._bankRepository);

  @override
  Future<Pair<int, List<BankEntity>>> call({Pair<String, int>? params}) async {
    if (params == null) {
      return Pair(0, []);
    }
    return await _bankRepository
        .searchBanks(params.first, params.second)
        .then((value) {
      if (value is DataSuccess) {
        return value.data ?? Pair(0, []);
      } else {
        return Pair(0, []);
      }
    });
  }
}

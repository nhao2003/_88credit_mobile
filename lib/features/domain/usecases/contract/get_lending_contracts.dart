import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/contract.dart';
import '../../repositories/request_repository.dart';

class GetLendingContractsUseCase
    implements UseCase<DataState<Pair<int, List<ContractEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetLendingContractsUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> call({int? params}) {
    return _requestRepository.getLendingContract(params);
  }
}

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/contract.dart';
import '../../repositories/request_repository.dart';

class GetBorrowingContractsUseCase
    implements UseCase<DataState<Pair<int, List<ContractEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetBorrowingContractsUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> call({int? params}) {
    return _requestRepository.getBorrowingContract(params);
  }
}

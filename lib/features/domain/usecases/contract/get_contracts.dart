import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/contract.dart';
import '../../enums/post_type.dart';
import '../../repositories/request_repository.dart';

class GetContractsUseCase
    implements
        UseCase<DataState<Pair<int, List<ContractEntity>>>,
            Pair<PostTypes, int?>> {
  final RequestRepository _requestRepository;

  GetContractsUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> call(
      {Pair<PostTypes, int?>? params}) {
    return _requestRepository.getContracts(params!.first, params.second);
  }
}

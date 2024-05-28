import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../repositories/request_repository.dart';

class GetRequestUseCase
    implements
        UseCase<DataState<Pair<int, List<LoanRequestEntity>>>,
            Pair<String?, int?>?> {
  final RequestRepository _requestRepository;

  GetRequestUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call(
      {Pair<String?, int?>? params}) {
    if (params == null) {
      return _requestRepository.getRequests(null, null);
    }
    return _requestRepository.getRequests(params.first, params.second);
  }
}

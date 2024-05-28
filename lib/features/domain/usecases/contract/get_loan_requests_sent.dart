import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../repositories/request_repository.dart';

class GetRequestSentUseCase
    implements UseCase<DataState<Pair<int, List<LoanRequestEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetRequestSentUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call({int? params}) {
    return _requestRepository.getRequestsSent(params);
  }
}

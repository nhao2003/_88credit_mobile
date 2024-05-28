import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../repositories/request_repository.dart';

class GetRequestWaitingPaymentUseCase
    implements UseCase<DataState<Pair<int, List<LoanRequestEntity>>>, int?> {
  final RequestRepository _requestRepository;

  GetRequestWaitingPaymentUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call({int? params}) {
    return _requestRepository.getRequestsWaitingPayment(params);
  }
}

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../repositories/request_repository.dart';

class CancelRequestUseCase
    implements UseCase<DataState<void>, LoanRequestEntity> {
  final RequestRepository _requestRepository;

  CancelRequestUseCase(this._requestRepository);

  @override
  Future<DataState<void>> call({LoanRequestEntity? params}) {
    return _requestRepository.cancelRequest(params!);
  }
}

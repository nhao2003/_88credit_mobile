import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../repositories/request_repository.dart';

class CreateRequestsUseCase
    implements UseCase<DataState<void>, LoanRequestEntity> {
  final RequestRepository _requestRepository;

  CreateRequestsUseCase(this._requestRepository);

  @override
  Future<DataState<void>> call({LoanRequestEntity? params}) {
    return _requestRepository.createRequest(params!);
  }
}

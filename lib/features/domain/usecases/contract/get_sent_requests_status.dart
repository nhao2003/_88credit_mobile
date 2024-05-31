import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/loan_request.dart';
import '../../enums/loan_contract_request_status.dart';
import '../../enums/request_types.dart';
import '../../repositories/request_repository.dart';

class GetSentRequestStatusUseCase
    implements
        UseCase<DataState<Pair<int, List<LoanRequestEntity>>>,
            Pair<LoanContractRequestStatus, int?>> {
  final RequestRepository _requestRepository;

  GetSentRequestStatusUseCase(this._requestRepository);

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> call(
      {Pair<LoanContractRequestStatus, int?>? params}) {
    return _requestRepository.getRequestsStatus(
      RequestTypes.sent,
      params!.first,
      params.second,
    );
  }
}

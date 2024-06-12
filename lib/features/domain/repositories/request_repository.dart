import '../../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/contract.dart';
import '../entities/loan_request.dart';
import '../enums/loan_contract_request_status.dart';
import '../enums/post_type.dart';
import '../enums/request_types.dart';

abstract class RequestRepository {
  // API remote
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequests(
      String? idUser, int? page);
  Future<DataState<LoanRequestEntity>> getSingleRequest(String id);
  Future<DataState<void>> createRequest(LoanRequestEntity request);

  Future<DataState<void>> confirmRequest(LoanRequestEntity request);
  Future<DataState<void>> rejectRequest(LoanRequestEntity request);
  Future<DataState<void>> cancelRequest(LoanRequestEntity request);
  // management
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequestsStatus(
      RequestTypes requestTypes, LoanContractRequestStatus status, int? page);

  Future<DataState<String>> payLoanRequest(String id);

  // contract
  Future<DataState<Pair<int, List<ContractEntity>>>> getContracts(
      PostTypes type, int? page);
}

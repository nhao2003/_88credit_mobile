import '../../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/contract.dart';
import '../entities/loan_request.dart';
import '../entities/transaction.dart';
import '../enums/loan_contract_request_status.dart';
import '../enums/request_types.dart';

abstract class RequestRepository {
  // API remote
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequests(
      String? idUser, int? page);
  Future<DataState<LoanRequestEntity>> getSingleRequest(String id);
  Future<DataState<void>> createRequest(LoanRequestEntity request);

  Future<DataState<void>> confirmRequest(LoanRequestEntity request);
  Future<DataState<void>> rejectRequest(
      LoanRequestEntity request, String reason);
  // management
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequestsStatus(
      RequestTypes requestTypes, LoanContractRequestStatus status, int? page);

  Future<DataState<TransactionEntity>> payLoanRequest(String id);

  // contract
  Future<DataState<Pair<int, List<ContractEntity>>>> getBorrowingContract(
      int? page);
  Future<DataState<Pair<int, List<ContractEntity>>>> getLendingContract(
      int? page);
}

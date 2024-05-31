import 'dart:io';
import 'package:dio/dio.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../domain/entities/contract.dart';
import '../../domain/entities/loan_request.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/enums/loan_contract_request_status.dart';
import '../../domain/enums/request_types.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/remote/requests_remote_data_source.dart';
import '../models/loan_request.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDataSrc _dataSrc;
  RequestRepositoryImpl(this._dataSrc);

  @override
  Future<DataState<void>> createRequest(LoanRequestEntity request) async {
    try {
      final httpResponse =
          await _dataSrc.createRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequests(
      String? idUser, int? page) async {
    try {
      final httpResponse = await _dataSrc.getAllRequests(idUser, page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Pair<int, List<LoanRequestEntity>>>> getRequestsStatus(
    RequestTypes requestTypes,
    LoanContractRequestStatus status,
    int? page,
  ) async {
    try {
      final httpResponse =
          await _dataSrc.getRequestsStatus(requestTypes, status, page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<LoanRequestEntity>> getSingleRequest(String id) {
    // TODO: implement getSingleRequest
    throw UnimplementedError();
  }

  @override
  Future<DataState<TransactionEntity>> payLoanRequest(String id) async {
    try {
      final httpResponse = await _dataSrc.payLoanRequest(id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> confirmRequest(LoanRequestEntity request) async {
    try {
      final httpResponse =
          await _dataSrc.confirmRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> rejectRequest(
      LoanRequestEntity request, String reason) async {
    try {
      final httpResponse = await _dataSrc.rejectRequest(
          LoanRequestModel.fromEntity(request), reason);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> getBorrowingContract(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getContracts(false, page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Pair<int, List<ContractEntity>>>> getLendingContract(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getContracts(true, page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

import 'dart:io';
import 'package:_88credit_mobile/features/domain/enums/post_type.dart';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../domain/entities/contract.dart';
import '../../domain/entities/loan_request.dart';
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
      print(
          'RequestRepositoryImpl.createRequest: ${LoanRequestModel.fromEntity(request)}');
      final httpResponse =
          await _dataSrc.createRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.created) {
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
  Future<DataState<String>> payLoanRequest(String id) async {
    try {
      final httpResponse = await _dataSrc.payLoanRequest(id);

      if (httpResponse.response.statusCode == HttpStatus.created) {
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

      if (httpResponse.response.statusCode == HttpStatus.created) {
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
  Future<DataState<void>> rejectRequest(LoanRequestEntity request) async {
    try {
      final httpResponse =
          await _dataSrc.rejectRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.created) {
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
  Future<DataState<void>> cancelRequest(LoanRequestEntity request) async {
    try {
      final httpResponse =
          await _dataSrc.cancelRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.created) {
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
  Future<DataState<void>> markPaidRequest(LoanRequestEntity request) async {
    try {
      final httpResponse =
          await _dataSrc.markPaidRequest(LoanRequestModel.fromEntity(request));

      if (httpResponse.response.statusCode == HttpStatus.created) {
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
  Future<DataState<Pair<int, List<ContractEntity>>>> getContracts(
      PostTypes type, int? page) async {
    try {
      final httpResponse = await _dataSrc.getContracts(type, page);

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

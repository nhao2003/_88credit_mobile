import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/query_builder.dart';
import '../../../../di/injection_container.dart';
import '../../../domain/enums/loan_contract_request_status.dart';
import '../../../domain/enums/request_types.dart';
import '../../models/contract.dart';
import '../../models/loan_request.dart';
import '../../models/transaction.dart';
import '../db/database_helper.dart';
import '../local/authentication_local_data_source.dart';

abstract class RequestRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getAllRequests(
      String? userId, int? page);
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsStatus(
      RequestTypes requestTypes, LoanContractRequestStatus status, int? page);
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsApproved(
      int? page);
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsPending(
      int? page);
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsSent(
      int? page);
  Future<HttpResponse<void>> createRequest(LoanRequestModel request);
  Future<HttpResponse<void>> confirmRequest(LoanRequestModel request);
  Future<HttpResponse<void>> rejectRequest(LoanRequestModel request);
  Future<HttpResponse<void>> cancelRequest(LoanRequestModel request);
  Future<HttpResponse<TransactionModel>> payLoanRequest(String id);

  Future<HttpResponse<Pair<int, List<ContractModel>>>> getContracts(
      bool isLending, int? page);
}

class RequestRemoteDataSrcImpl implements RequestRemoteDataSrc {
  final Dio client;

  RequestRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<void>> createRequest(LoanRequestModel request) async {
    const url = '$apiUrl$kCreateRequestEndpoint';
    print(request.toJson());
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      // Gửi yêu cầu đến server

      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
        data: request.toJson(),
      );

      print(response.data);

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      return HttpResponse(null, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? "Error when create post",
        statusCode: e.response?.statusCode ?? 505,
      );
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getAllRequests(
      String? userId, int? page) async {
    var url = '$apiUrl$kGetRequestEndpoint';

    QueryBuilder queryBuilder = QueryBuilder();
    int pageQuery = page ?? 1;
    queryBuilder.addPage(pageQuery);

    if (userId != null) {
      queryBuilder.addQuery('receiverId', Operation.equals, '\'$userId\'');
    }

    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    url += queryBuilder.build();
    return await DatabaseHelper().getRequests(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsApproved(
      int? page) async {
    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery(
        'status', Operation.inValue, LoanContractRequestStatus.paid.toString());
    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    String url = '$apiUrl$kGetRequestEndpoint${queryBuilder.build()}';

    return await DatabaseHelper().getRequests(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsStatus(
    RequestTypes requestTypes,
    LoanContractRequestStatus status,
    int? page,
  ) async {
    String typeRequest = "";
    if (requestTypes == RequestTypes.sent) {
      typeRequest = '/sent';
    } else {
      typeRequest = '/received';
    }

    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery('status', Operation.inValue, status.toString());
    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    String url =
        '$apiUrl$kGetRequestEndpoint$typeRequest${queryBuilder.build()}';

    return await DatabaseHelper().getRequests(url, client);
  }

  @override
  Future<HttpResponse<TransactionModel>> payLoanRequest(String id) {
    var url = '$apiUrl$kPayLoanRequestEndpoint/$id';
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? accessToken = localDataSrc.getAccessToken();
    if (accessToken == null) {
      throw const ApiException(
          message: 'Access token is null', statusCode: 505);
    }
    return client
        .patch(url,
            options: Options(
                sendTimeout: const Duration(seconds: 10),
                headers: {'Authorization': 'Bearer $accessToken'}))
        .then((value) {
      return HttpResponse<TransactionModel>(
          TransactionModel.fromJson(value.data["result"]), value);
    }).catchError((error) {
      throw ErrorHelpers.handleException(error);
    });
  }

  @override
  Future<HttpResponse<void>> confirmRequest(LoanRequestModel request) async {
    String url =
        '$apiUrl$kGetRequestEndpoint/${request.id}$kConfirmRequestEndpoint';
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      // Gửi yêu cầu đến server

      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print(response);

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      return HttpResponse(null, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? "Error when create post",
        statusCode: e.response?.statusCode ?? 505,
      );
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<void>> rejectRequest(LoanRequestModel request) async {
    String url =
        '$apiUrl$kGetRequestEndpoint/${request.id}$kRejectRequestEndpoint';
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      // Gửi yêu cầu đến server

      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print(response);

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      return HttpResponse(null, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? "Error when create post",
        statusCode: e.response?.statusCode ?? 505,
      );
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<void>> cancelRequest(LoanRequestModel request) async {
    String url =
        '$apiUrl$kGetRequestEndpoint/${request.id}$kCancelRequestEndpoint';
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
      print(response);

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      return HttpResponse(null, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message ?? "Error when create post",
        statusCode: e.response?.statusCode ?? 505,
      );
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsPending(
      int? page) async {
    // get userId
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? userId = localDataSrc.getUserIdFromToken();

    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery('status', Operation.inValue,
        LoanContractRequestStatus.pending.toString());

    queryBuilder.addQuery('receiverId', Operation.equals, '\'$userId\'');

    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    String url = '$apiUrl$kGetRequestEndpoint${queryBuilder.build()}';

    return await DatabaseHelper().getRequests(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequestsSent(
      int? page) async {
    // get userId
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? userId = localDataSrc.getUserIdFromToken();

    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery('status', Operation.inValue,
        LoanContractRequestStatus.pending.toString());

    queryBuilder.addQuery('senderId', Operation.equals, '\'$userId\'');

    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    String url = '$apiUrl$kGetRequestEndpoint${queryBuilder.build()}';

    return await DatabaseHelper().getRequests(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<ContractModel>>>> getContracts(
      bool isLending, int? page) async {
    // get userId
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? userId = localDataSrc.getUserIdFromToken();

    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);

    if (isLending) {
      queryBuilder.addQuery(
          'contractLenderId', Operation.equals, '\'$userId\'');
    } else {
      queryBuilder.addQuery(
          'contractBorrowerId', Operation.equals, '\'$userId\'');
    }

    queryBuilder.addOrderBy('createdAt', OrderBy.desc);

    String url = '$apiUrl$kGetContractEndpoint${queryBuilder.build()}';

    return await DatabaseHelper().getContracts(url, client);
  }
}

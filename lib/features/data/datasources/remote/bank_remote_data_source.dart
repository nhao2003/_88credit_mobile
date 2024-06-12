import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../di/injection_container.dart';
import '../../models/bank.dart';
import '../../models/bank_card.dart';
import '../local/authentication_local_data_source.dart';

abstract class BankRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<BankModel>>>> getAllBanks(
      String query, int page);
  Future<HttpResponse<List<BankCardModel>>> getBankCards();
  Future<HttpResponse<void>> markAsPrimaryBankCard(String id);
  Future<HttpResponse<void>> addBankCard(BankCardModel bankCardModel);
  Future<HttpResponse<void>> deleteBankCard(String id);
  Future<HttpResponse<BankCardModel>> getPrimaryBankCard();
}

class BankRemoteDataSrcImpl extends BankRemoteDataSrc {
  final Dio client;

  BankRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<Pair<int, List<BankModel>>>> getAllBanks(
      String query, int page) async {
    String url = '$apiUrl$kGetBankEndpoint?take=100';

    if (query.trim().isNotEmpty) {
      url += '?search=$query';
    }

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 1000);
      }
      final response = await client.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      List<BankModel> banks = [];
      if (response.data['data']['items'] != null) {
        banks = (response.data['data']['items'] as List<dynamic>? ?? [])
            .map((e) => BankModel.fromJson(e))
            .toList();
      }

      return HttpResponse<Pair<int, List<BankModel>>>(
        Pair(1, banks),
        response,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }

  @override
  Future<HttpResponse<List<BankCardModel>>> getBankCards() async {
    String url = '$apiUrl$kGetBankCardEndpoint';

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      List<BankCardModel> bankCards = [];
      if (response.data['data'] != null) {
        bankCards = (response.data['data'] as List<dynamic>? ?? [])
            .map((e) => BankCardModel.fromJson(e))
            .toList();
      }

      return HttpResponse<List<BankCardModel>>(
        bankCards,
        response,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }

  @override
  Future<HttpResponse<void>> markAsPrimaryBankCard(String id) async {
    String url = '$apiUrl$kGetBankCardEndpoint/$id$kGetMarkPrimaryEndpoint';

    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.patch(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print(response);

      if (response.statusCode != HttpStatus.ok) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      return HttpResponse<void>(
        null,
        response,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }

  @override
  Future<HttpResponse<void>> addBankCard(BankCardModel bankCardModel) async {
    const url = '$apiUrl$kGetBankCardEndpoint';
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
        data: bankCardModel.toJson(),
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
        message: e.message ?? "Error when create bank card",
        statusCode: e.response?.statusCode ?? 505,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }

  @override
  Future<HttpResponse<void>> deleteBankCard(String id) async {
    String url = '$apiUrl$kGetBankCardEndpoint/$id';

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.delete(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      return HttpResponse<void>(
        null,
        response,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }

  @override
  Future<HttpResponse<BankCardModel>> getPrimaryBankCard() async {
    String url = '$apiUrl$kGetPrimaryBankCardEndpoint';

    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print(response);

      if (response.statusCode != HttpStatus.ok) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      BankCardModel bankCard = const BankCardModel();
      if (response.data['data'] != null) {
        bankCard = BankCardModel.fromJson(response.data['data']);
      }

      return HttpResponse<BankCardModel>(
        bankCard,
        response,
      );
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }
}

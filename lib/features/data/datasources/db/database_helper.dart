import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../di/injection_container.dart';
import '../../models/contract.dart';
import '../../models/loan_request.dart';
import '../../models/post.dart';
import '../local/authentication_local_data_source.dart';

class DatabaseHelper {
  Future<HttpResponse<Pair<int, List<PostModel>>>> getPosts(
      String url, Dio client) async {
    try {
      print("Get Posts url: $url");
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

      // final response = await client.get(url);
      print('Code: ${response.statusCode}');
      if (response.statusCode != HttpStatus.ok) {
        print('${response.statusCode} : ${response.data["data"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["data"]["totalPages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["data"]["items"]);

      List<PostModel> posts = [];
      for (var element in taskDataList) {
        posts.add(PostModel.fromJson(element));
      }

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  Future<HttpResponse<Pair<int, List<LoanRequestModel>>>> getRequests(
      String url, Dio client) async {
    try {
      // get access token
      print("Request url: $url");

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
        print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["data"]["totalPages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["data"]["items"]);

      List<LoanRequestModel> posts = [];
      for (var element in taskDataList) {
        posts.add(LoanRequestModel.fromJson(element));
      }

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  Future<HttpResponse<Pair<int, List<ContractModel>>>> getContracts(
      String url, Dio client) async {
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
      //print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != HttpStatus.ok) {
        //print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["data"]["totalPages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["data"]["items"]);

      List<ContractModel> posts = [];
      for (var element in taskDataList) {
        posts.add(ContractModel.fromJson(element));
      }

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }
}

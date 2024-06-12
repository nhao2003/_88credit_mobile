import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/query_builder.dart';
import '../../../../di/injection_container.dart';
import '../../models/user.dart';
import '../local/authentication_local_data_source.dart';

abstract class UserRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<UserModel>>>> searchUsers(
      String query, int page);
  Future<HttpResponse<UserModel>> getProfile();
  Future<HttpResponse<UserModel>> getUserById(String idUser);
}

class UserRemoteDataSrcImpl extends UserRemoteDataSrc {
  final Dio client;

  UserRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<Pair<int, List<UserModel>>>> searchUsers(
      String query, int page) {
    String url = '$apiUrl$kGetUserEndpoint';

    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(page);

    if (query.trim().isNotEmpty) {
      url += '?search=$query';
    }

    url += queryBuilder.build();
    try {
      return client.get(url).then((response) {
        List<UserModel> users = [];
        if (response.data['data']['items'] != null) {
          users = (response.data['data']['items'] as List<dynamic>? ?? [])
              .map((e) => UserModel.fromJson(e))
              .toList();
        }

        return HttpResponse<Pair<int, List<UserModel>>>(
          Pair(response.data['data']['totalPages'], users),
          response,
        );
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<UserModel>> getProfile() async {
    String url = '$apiUrl$kGetUserEndpoint';

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      String userId = localDataSrc.getUserIdFromToken();

      url += '/$userId';

      print(url);

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

      UserModel user = UserModel.fromJson(response.data['data']);

      return HttpResponse<UserModel>(
        user,
        response,
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<UserModel>> getUserById(String idUser) async {
    String url = '$apiUrl$kGetUserEndpoint/$idUser';

    try {
      final response = await client.get(url);

      if (response.statusCode != HttpStatus.ok) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      UserModel user = UserModel.fromJson(response.data['data']);

      return HttpResponse<UserModel>(
        user,
        response,
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}

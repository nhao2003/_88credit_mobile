import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../models/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSrc _userRemoteDataSrc;

  UserRepositoryImpl(this._userRemoteDataSrc);

  @override
  Future<DataState<Pair<int, List<UserModel>>>> searchUsers(
      String query, int page) async {
    try {
      final httpResponse = await _userRemoteDataSrc.searchUsers(query, page);

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
  Future<DataState<UserEntity>> getProfile() async {
    try {
      final httpResponse = await _userRemoteDataSrc.getProfile();

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
  Future<DataState<UserEntity>> getUserById(String idUser) async {
    try {
      final httpResponse = await _userRemoteDataSrc.getUserById(idUser);

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

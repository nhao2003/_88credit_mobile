import 'dart:io';

import 'package:_88credit_mobile/core/resources/data_state.dart';
import 'package:_88credit_mobile/features/data/datasources/remote/ekyc_remote_data_source.dart';
import 'package:_88credit_mobile/features/data/models/back_card_info.dart';
import 'package:_88credit_mobile/features/data/models/front_card_info.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/ekyc_repository.dart';

class EkycRepositoryImpl implements EkycRepository {
  final EkycRemoteDataSrc ekycRemoteDataSrc;

  EkycRepositoryImpl(this.ekycRemoteDataSrc);

  @override
  Future<DataState<String>> initEkycRequest() async {
    try {
      final response = await ekycRemoteDataSrc.initEkycRequest();
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> sendFace(String requestId, File image) async {
    try {
      final response = await ekycRemoteDataSrc.sendFace(requestId, image);
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<BackCardInfo>> sendOCRBack(
      String requestId, File image) async {
    try {
      final response = await ekycRemoteDataSrc.sendOCRBack(requestId, image);
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<FrontCardInfo>> sendOCRFront(
      String requestId, File image) async {
    try {
      final response = await ekycRemoteDataSrc.sendOCRFront(requestId, image);
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> sendVideoSefie(String requestId, File video) async {
    try {
      final response = await ekycRemoteDataSrc.sendVideoSefie(requestId, video);
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> submit(String requestId) async {
    try {
      final response = await ekycRemoteDataSrc.submit(requestId);
      if (response.response.statusCode == HttpStatus.created) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(DioException(
          error: response.response.statusMessage,
          response: response.response,
          type: DioExceptionType.badResponse,
          requestOptions: response.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

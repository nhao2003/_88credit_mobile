import 'dart:io';

import 'package:_88credit_mobile/features/data/models/ekyc_request.dart';
import 'package:_88credit_mobile/features/data/models/front_card_info.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../../../config/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../di/injection_container.dart';
import '../../models/back_card_info.dart';
import '../local/authentication_local_data_source.dart';

abstract class EkycRemoteDataSrc {
  Future<HttpResponse<String>> initEkycRequest();
  Future<HttpResponse<void>> sendOCRFront(String requestId, File image);
  Future<HttpResponse<void>> sendOCRBack(String requestId, File image);
  Future<HttpResponse<void>> sendFace(String requestId, File image);
  Future<HttpResponse<void>> sendVideoSefie(String requestId, File video);
  Future<HttpResponse<void>> submit(String requestId);
}

class EkycRemoteDataSrcImpl implements EkycRemoteDataSrc {
  final Dio client;

  EkycRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<String>> initEkycRequest() async {
    const url = '$apiUrl$kInitEkycEndpoint';
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();

      // Gửi yêu cầu đến server
      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      final request = EkycRequestModel.fromJson(response.data["data"]);

      return HttpResponse(request.id!, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<void>> sendOCRFront(String requestId, File image) async {
    var url = '$apiUrl$kOrcFrontEndpoint/$requestId';
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();

      String fileName = image.path.split('/').last;
      print("filename: $fileName");

      MultipartFile multipartFile =
          await MultipartFile.fromFile(image.path, filename: fileName);

      FormData formData = FormData.fromMap({
        "file": multipartFile,
        "title": "Ảnh mặt trước",
        "description": "Ảnh mặt trước của user",
      });

      // Gửi yêu cầu đến server
      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
        data: formData,
      );

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      final request = FrontCardInfo.fromJson(response.data["data"]);

      print(request.toString());

      return HttpResponse(null, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<void>> sendOCRBack(String requestId, File image) async {
    var url = '$apiUrl$kOrcBackEndpoint/$requestId';
    try {
      print(url);
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();

      String fileName = image.path.split('/').last;
      print("filename: $fileName");

      MultipartFile multipartFile =
          await MultipartFile.fromFile(image.path, filename: fileName);

      FormData formData = FormData.fromMap({
        "file": multipartFile,
        "title": "Ảnh sau cccd",
        "description": "Ảnh sau cccd",
      });

      // Gửi yêu cầu đến server
      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
        data: formData,
      );

      if (response.statusCode != HttpStatus.created) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      final request = BackCardInfo.fromJson(response.data["data"]);

      print(request.toString());

      return HttpResponse(null, response);
    } catch (error) {
      throw ErrorHelpers.handleException(error);
    }
  }

  @override
  Future<HttpResponse<void>> sendFace(String requestId, File image) async {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> sendVideoSefie(
      String requestId, File video) async {
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> submit(String requestId) async {
    throw UnimplementedError();
  }
}

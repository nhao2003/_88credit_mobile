import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/dio.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../di/injection_container.dart';
import '../local/authentication_local_data_source.dart';

abstract class MediaRemoteDataSource {
  Future<HttpResponse<String>> uploadMedia(File media, String? folderName);
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final Dio client;

  MediaRemoteDataSourceImpl(this.client);

  MediaType getMediaType(String path) {
    final ext = path.split('.').last;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpg');
      case 'png':
        return MediaType('image', 'png');
      case 'mp4':
        return MediaType('video', 'mp4');
      default:
        throw const ApiException(
            message: 'Media type not supported', statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<String>> uploadMedia(
      File media, String? folderName) async {
    const url = '$apiUrl$kUploadMediaEndpoint';
    print(url);
    try {
      print("Uploading media: ${media.path}");

      // authen
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 1000);
      }

      String fileName = media.path.split('/').last;
      print("filename: $fileName");

      // Kiểm tra xem file có tồn tại không
      bool fileExists = await media.exists();
      if (!fileExists) {
        throw Exception("File does not exist: ${media.path}");
      }

      // Tạo MultipartFile
      MultipartFile multipartFile =
          await MultipartFile.fromFile(media.path, filename: fileName);
      print(
          "MultipartFile: ${multipartFile.filename}, ${multipartFile.length}");

      // Tạo FormData
      FormData formData = FormData.fromMap({
        "file": multipartFile,
        "folder": folderName ?? "",
      });

      // In log chi tiết FormData
      print("FormData: ${formData.fields}");

      final response = await client.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
        data: formData,
      );

      if (response.statusCode != HttpStatus.created) {
        throw DioException(
          error: response.data,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        );
      }

      print("Response: ${response.data["data"]}");

      final data = response.data["data"];

      return HttpResponse(data, response);
    } catch (error) {
      print(error);
      throw ErrorHelpers.handleException(error);
    }
  }
}

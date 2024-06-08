import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../domain/repositories/media_repository.dart';
import '../datasources/remote/media_remote_date_source.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRemoteDataSource mediaDataSource;

  MediaRepositoryImpl(this.mediaDataSource);

  @override
  Future<DataState<String>> uploadMedia(File media, String? folderName) async {
    try {
      final response = await mediaDataSource.uploadMedia(media, folderName);
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

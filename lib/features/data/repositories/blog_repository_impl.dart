import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../domain/entities/blog.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/remote/blog_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSrc blogRemoteDataSrc;

  BlogRepositoryImpl(this.blogRemoteDataSrc);

  @override
  Future<DataState<List<BlogEntity>>> getAllBlogs() async {
    try {
      final httpResponse = await blogRemoteDataSrc.getAllBlogs();

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

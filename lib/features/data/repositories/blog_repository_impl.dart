import 'dart:io';
import 'package:_88credit_mobile/features/data/models/blog.dart';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../domain/entities/blog.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/db/app_database.dart';
import '../datasources/remote/blog_data_source.dart';
import '../models/blog_adapter.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSrc blogRemoteDataSrc;
  final AppDatabase appDatabase;

  BlogRepositoryImpl(this.blogRemoteDataSrc, this.appDatabase);

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

  @override
  Future<List<BlogModel>> getLocalBlogs() async {
    final blogLocalModels = await appDatabase.blogDao.getAllBlogs();
    IBlogModelAdapter adapter = BlogModelAdapter();
    return blogLocalModels
        .map((blogLocalModel) => adapter.toBlogModel(blogLocalModel))
        .toList();
  }

  @override
  Future<void> insertLocalBlogs(List<BlogEntity> blogs) async {
    IBlogModelAdapter adapter = BlogModelAdapter();
    final blogLocalModels = blogs.map((blogEntity) {
      if (blogEntity is BlogModel) {
        return adapter.fromBlogModel(blogEntity);
      } else {
        throw Exception("Invalid type: Expected BlogModel");
      }
    }).toList();
    await appDatabase.blogDao.insertBlogs(blogLocalModels);
  }

  @override
  Future<void> deleteLocalBlogs() async {
    await appDatabase.blogDao.deleteAllBlogs();
  }
}

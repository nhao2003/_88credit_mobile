import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../domain/entities/post.dart';
import '../../domain/enums/post_type.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/remote/post_remote_data_sources.dart';
import '../models/post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSrc _dataSrc;
  PostRepositoryImpl(this._dataSrc);

  @override
  Future<DataState<Pair<int, List<PostEntity>>>> getPosts(
      String? userId, PostTypes? postTypes, int? page) async {
    try {
      final httpResponse = await _dataSrc.getAllPosts(userId, postTypes, page);

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
  Future<DataState<void>> createPost(PostEntity post) async {
    try {
      final httpResponse =
          await _dataSrc.createPost(PostModel.fromEntity(post));
      if (httpResponse.response.statusCode == HttpStatus.created) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> deletePost(String id) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<PostEntity>> getSinglePost(String id) async {
    // TODO: implement getSinglePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<void>> updatePost(PostEntity post) async {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsApproved(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("approved", page);

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
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsHided(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getPostsHided(page);

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
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsPending(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("pending", page);

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
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsRejected(
      int? page) async {
    try {
      final httpResponse = await _dataSrc.getPostsStatus("rejected", page);

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
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsExpired(int? page) {
    // TODO: implement getPostsExpired
    throw UnimplementedError();
  }
}

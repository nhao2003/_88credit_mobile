import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../../config/constants/constants.dart';
import '../../../../di/injection_container.dart';
import '../../models/blog.dart';
import '../local/authentication_local_data_source.dart';

abstract class BlogRemoteDataSrc {
  Future<HttpResponse<List<BlogModel>>> getAllBlogs();
}

class BlogRemoteDataSrcImpl implements BlogRemoteDataSrc {
  
  final Dio client;

  BlogRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<BlogModel>>> getAllBlogs() async {
    const url = '$apiUrl$kGetBlogEndpoint';

    try {
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

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["data"]["items"]);

      List<BlogModel> value =
          taskDataList.map((postJson) => BlogModel.fromJson(postJson)).toList();

      return HttpResponse(value, response);
    } catch (e) {
      throw ErrorHelpers.handleException(e);
    }
  }
}



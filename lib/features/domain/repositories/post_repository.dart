import '../../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../entities/post.dart';
import '../enums/post_type.dart';

abstract class PostRepository {
  // API remote
  Future<DataState<Pair<int, List<PostEntity>>>> getPosts(
      String? idUser, PostTypes? postTypes, int? page);
  Future<DataState<PostEntity>> getSinglePost(String id);
  Future<DataState<void>> createPost(PostEntity post);
  Future<DataState<void>> updatePost(PostEntity post);
  Future<DataState<void>> deletePost(String id);
  // management
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsApproved(int? page);
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsHided(int? page);
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsPending(int? page);
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsRejected(int? page);
  Future<DataState<Pair<int, List<PostEntity>>>> getPostsExpired(int? page);
}

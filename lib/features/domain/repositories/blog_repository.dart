import '../../../core/resources/data_state.dart';
import '../entities/blog.dart';

abstract class BlogRepository {
  Future<DataState<List<BlogEntity>>> getAllBlogs();

  // database local
  Future<List<BlogEntity>> getLocalBlogs();
  Future<void> insertLocalBlogs(List<BlogEntity> blogs);
  Future<void> deleteLocalBlogs();
}

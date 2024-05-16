import '../../../core/resources/data_state.dart';
import '../entities/blog.dart';

abstract class BlogRepository {
  Future<DataState<List<BlogEntity>>> getAllBlogs();
}

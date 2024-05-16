import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/blog.dart';
import '../../repositories/blog_repository.dart';

class GetBlogsUseCase implements UseCase<DataState<List<BlogEntity>>, void> {
  final BlogRepository _blogRepository;

  GetBlogsUseCase(this._blogRepository);

  @override
  Future<DataState<List<BlogEntity>>> call({void params}) {
    return _blogRepository.getAllBlogs();
  }
}

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post_repository.dart';

class CreatePostsUseCase implements UseCase<DataState<void>, PostEntity> {
  final PostRepository _postRepository;

  CreatePostsUseCase(this._postRepository);

  @override
  Future<DataState<void>> call({PostEntity? params}) {
    return _postRepository.createPost(params!);
  }
}

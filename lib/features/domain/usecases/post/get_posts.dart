import 'package:_88credit_mobile/features/domain/enums/post_type.dart';

import '../../../../../core/resources/pair.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post_repository.dart';

class GetPostsUseCase
    implements
        UseCase<DataState<Pair<int, List<PostEntity>>>,
            Pair<PostTypes?, int?>?> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<Pair<int, List<PostEntity>>>> call(
      {Pair<PostTypes?, int?>? params}) {
    if (params == null) {
      return _postRepository.getPosts(null, null, null);
    }
    return _postRepository.getPosts(null, params.first, params.second);
  }
}

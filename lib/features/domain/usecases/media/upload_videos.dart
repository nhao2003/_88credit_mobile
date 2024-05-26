import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/media_repository.dart';

class UploadVideosUseCase
    implements UseCase<DataState<List<String>>, List<File>> {
  final MediaRepository _postRepository;

  UploadVideosUseCase(this._postRepository);

  @override
  Future<DataState<List<String>>> call({List<File>? params}) {
    return _postRepository.uploadMedia(params!, 'video');
  }
}

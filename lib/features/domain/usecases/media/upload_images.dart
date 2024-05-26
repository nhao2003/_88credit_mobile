import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/media_repository.dart';

class UploadImagesUseCase
    implements UseCase<DataState<List<String>>, List<File>> {
  final MediaRepository _postRepository;

  UploadImagesUseCase(this._postRepository);

  @override
  Future<DataState<List<String>>> call({List<File>? params}) {
    return _postRepository.uploadMedia(params!, "image");
  }
}

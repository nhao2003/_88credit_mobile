import 'dart:io';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/media_repository.dart';

class UploadFileUseCase implements UseCase<DataState<String>, Pair<File, String?>> {
  final MediaRepository _postRepository;

  UploadFileUseCase(this._postRepository);

  @override
  Future<DataState<String>> call({Pair<File, String?>? params}) {
    return _postRepository.uploadMedia(params!.first, params.second);
  }
}

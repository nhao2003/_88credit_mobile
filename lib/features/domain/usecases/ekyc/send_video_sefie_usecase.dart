import 'dart:io';
import 'package:_88credit_mobile/core/resources/pair.dart';
import 'package:_88credit_mobile/features/domain/repositories/ekyc_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

class SendVideoSefieUseCase
    implements UseCase<DataState<void>, Pair<String, File>> {
  final EkycRepository _ekycRepository;

  SendVideoSefieUseCase(this._ekycRepository);

  @override
  Future<DataState<void>> call({Pair<String, File>? params}) {
    return _ekycRepository.sendVideoSefie(params!.first, params.second);
  }
}

import 'dart:io';
import 'package:_88credit_mobile/core/resources/pair.dart';
import 'package:_88credit_mobile/features/data/models/back_card_info.dart';
import 'package:_88credit_mobile/features/domain/repositories/ekyc_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

class SendOcrBackUseCase
    implements UseCase<DataState<BackCardInfo>, Pair<String, File>> {
  final EkycRepository _ekycRepository;

  SendOcrBackUseCase(this._ekycRepository);

  @override
  Future<DataState<BackCardInfo>> call({Pair<String, File>? params}) {
    return _ekycRepository.sendOCRBack(params!.first, params.second);
  }
}

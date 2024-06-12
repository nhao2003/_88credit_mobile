import 'dart:io';
import 'package:_88credit_mobile/core/resources/pair.dart';
import 'package:_88credit_mobile/features/data/models/front_card_info.dart';
import 'package:_88credit_mobile/features/domain/repositories/ekyc_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

class SendOcrFrontUseCase
    implements UseCase<DataState<FrontCardInfo>, Pair<String, File>> {
  final EkycRepository _ekycRepository;

  SendOcrFrontUseCase(this._ekycRepository);

  @override
  Future<DataState<FrontCardInfo>> call({Pair<String, File>? params}) {
    return _ekycRepository.sendOCRFront(params!.first, params.second);
  }
}

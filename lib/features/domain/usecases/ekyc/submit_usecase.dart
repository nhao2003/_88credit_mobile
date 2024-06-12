import 'package:_88credit_mobile/features/domain/repositories/ekyc_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

class SubmitUseCase implements UseCase<DataState<void>, String> {
  final EkycRepository _ekycRepository;

  SubmitUseCase(this._ekycRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _ekycRepository.submit(params!);
  }
}

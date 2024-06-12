import 'package:_88credit_mobile/features/domain/repositories/ekyc_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';

class InitRequestUseCase implements UseCase<DataState<String>, void> {
  final EkycRepository _ekycRepository;

  InitRequestUseCase(this._ekycRepository);

  @override
  Future<DataState<String>> call({void params}) {
    return _ekycRepository.initEkycRequest();
  }
}

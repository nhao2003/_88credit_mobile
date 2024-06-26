import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class CheckActiveTokenUseCase implements UseCaseSync<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  CheckActiveTokenUseCase(this._authenRepository);

  @override
  DataState<bool> call({void params}) {
    final data = _authenRepository.checkAccessTokenIsValid();
    return data;
  }
}

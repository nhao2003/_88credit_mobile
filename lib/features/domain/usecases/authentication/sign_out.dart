import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class SignOutUseCase implements UseCase<DataState<void>, void> {
  final AuthenticationRepository _authenRepository;

  SignOutUseCase(this._authenRepository);

  @override
  Future<DataState<void>> call({void params}) {
    return _authenRepository.signOut();
  }
}

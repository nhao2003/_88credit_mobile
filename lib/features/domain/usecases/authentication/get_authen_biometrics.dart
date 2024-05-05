import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class GetAuthenticateBiometrics implements UseCase<bool, void> {
  final AuthenticationRepository repository;

  GetAuthenticateBiometrics(this.repository);

  @override
  Future<bool> call({void params}) async {
    final result = await repository.getAuthenticateBiometrics();
    return result.data!;
  }
}

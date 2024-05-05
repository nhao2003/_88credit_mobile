import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class GetAccessTokenUseCase implements UseCase<String, void> {
  final AuthenticationRepository repository;

  GetAccessTokenUseCase(this.repository);

  @override
  Future<String> call({void params}) async {
    final accessToken = repository.getAccessToken();
    return accessToken.data!;
  }
}

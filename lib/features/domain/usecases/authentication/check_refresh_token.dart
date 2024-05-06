import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class CheckRefreshTokenUseCase implements UseCase<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  // final ConversationRepository _conversationRepository;
  CheckRefreshTokenUseCase(this._authenRepository);

  @override
  Future<DataState<bool>> call({void params}) async {
    // final result = await _authenRepository.refreshNewAccessToken();
    final result = _authenRepository.checkRefreshTokenIsValid();
    return result;
  }
}

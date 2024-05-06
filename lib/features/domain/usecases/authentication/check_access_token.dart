import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class CheckAccessTokenUseCase implements UseCase<DataState<bool>, void> {
  final AuthenticationRepository _authenRepository;

  // final ConversationRepository _conversationRepository;
  CheckAccessTokenUseCase(this._authenRepository);

  @override
  Future<DataState<bool>> call({void params}) async {
    // final result = await _authenRepository.refreshNewAccessToken();
    final result = _authenRepository.checkAccessTokenIsValid();
    return const DataSuccess(false);
  }
}

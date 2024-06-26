import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';

class SignUpUseCase
    implements UseCase<DataState<String>, Map<String, dynamic>?> {
  final AuthenticationRepository _authenRepository;
  // final ConversationRepository _conversationRepository;

  // SignUpUseCase(this._authenRepository, this._conversationRepository);
  SignUpUseCase(this._authenRepository);

  @override
  Future<DataState<String>> call({Map<String, dynamic>? params}) async {
    final data = await _authenRepository.signUp(
        params!['email'], params['password'], params['confirmPassword']);
    if (data is DataSuccess) {
      // _conversationRepository.connect();
    }
    return data;
  }
}

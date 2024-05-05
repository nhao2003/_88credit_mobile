import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/authentication_repository.dart';
import '../../repositories/conversation_repository.dart';

class SignInUseCase implements UseCase<DataState<void>, Map<String, dynamic>?> {
  final ConversationRepository _conversationRepository;
  final AuthenticationRepository _authenRepository;

  SignInUseCase(this._authenRepository, this._conversationRepository);

  @override
  Future<DataState<void>> call({Map<String, dynamic>? params}) {
    final data = _authenRepository.signIn(params!['email'], params['password']);
    if (data is DataSuccess) {
      _conversationRepository.connect();
    }
    return data;
  }
}

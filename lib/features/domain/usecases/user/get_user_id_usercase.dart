import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUserByIdUsecase implements UseCase<UserEntity?, String> {
  final UserRepository _userRepository;

  GetUserByIdUsecase(this._userRepository);

  @override
  Future<UserEntity?> call({String? params}) async {
    return await _userRepository.getUserById(params!).then((value) {
      if (value is DataSuccess) {
        return value.data!;
      } else {
        return null;
      }
    });
  }
}

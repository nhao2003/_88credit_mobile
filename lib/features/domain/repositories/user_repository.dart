import '../../../core/resources/data_state.dart';
import '../../../core/resources/pair.dart';
import '../../data/models/user.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<DataState<Pair<int, List<UserModel>>>> searchUsers(
      String query, int page);
  Future<DataState<UserEntity>> getUserById(String idUser);
  Future<DataState<UserEntity>> getProfile();
}

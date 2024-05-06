import 'package:_88credit_mobile/features/domain/entities/user.dart';
import '../../../../core/resources/data_state.dart';

abstract class AuthenticationRepository {
  bool get isLoggedIn;
  set isLoggedIn(bool value);

  // API remote
  Future<DataState<void>> signIn(String email, String password);
  Future<DataState<void>> signInWithToken();
  Future<DataState<void>> signOut();
  Future<DataState<String>> signUp(
      String email, String password, String confirmPassword);

  // Local
  DataState<String> getAccessToken();
  DataState<bool> checkAccessTokenIsValid();
  DataState<bool> checkRefreshTokenIsValid();
  Future<DataState<void>> refreshNewAccessToken();
  DataState<String> getUserId();

  // Fingerprinting
  Future<DataState<bool>> getAuthenticateBiometrics();

  void addAuthStateListener(Function(bool) listener);
  void removeAuthStateListener(Function(bool) listener);
  void notifyAuthStateListeners();

  Future<DataState<UserEntity>> getMe();
}

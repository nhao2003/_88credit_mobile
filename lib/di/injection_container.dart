import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/data/datasources/local/authentication_local_data_source.dart';
import '../features/data/datasources/remote/authentication_remote_data_source.dart';
import '../features/data/repositories/authentication_repository_impl.dart';
import '../features/domain/repositories/authentication_repository.dart';
import '../features/domain/usecases/authentication/check_token.dart';
import '../features/domain/usecases/authentication/get_access_token.dart';
import '../features/domain/usecases/authentication/get_user_id.dart';
import '../features/domain/usecases/authentication/sign_in.dart';
import '../features/domain/usecases/authentication/sign_out.dart';
import '../features/domain/usecases/authentication/sign_up.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());
  // Authentication
  _initAuth();
}

void _initAuth() async {
  // datasource
  sl.registerSingleton<AuthenRemoteDataSrc>(
    AuthenRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  sl.registerSingleton<AuthenLocalDataSrc>(
    AuthenLocalDataSrcImpl(await SharedPreferences.getInstance()),
  );
  // repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      sl<AuthenRemoteDataSrc>(),
      sl<AuthenLocalDataSrc>(),
    ),
  );
  // use cases
  sl.registerSingleton<CheckTokenUseCase>(
    CheckTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<GetUserIdUseCase>(
    GetUserIdUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<GetAccessTokenUseCase>(
    GetAccessTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<SignOutUseCase>(
    SignOutUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(
      sl<AuthenticationRepository>(),
    ),
  );
}

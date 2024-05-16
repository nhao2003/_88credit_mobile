part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // AppPages
  sl.registerSingleton<MyAppPages>(MyAppPages());
  // Dio
  sl.registerSingleton<Dio>(Dio());
  // Authentication
  await _initAuth();
  await _initBlog();
}

Future<void> _initAuth() async {
  // datasource
  sl.registerSingleton<AuthenRemoteDataSrc>(
    AuthenRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  sl.registerSingleton<AuthenLocalDataSrc>(
    AuthenLocalDataSrcImpl(
      await SharedPreferences.getInstance(),
      LocalAuthentication(),
    ),
  );
  // repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      sl<AuthenRemoteDataSrc>(),
      sl<AuthenLocalDataSrc>(),
    ),
  );
  // use cases
  sl.registerSingleton<CheckAccessTokenUseCase>(
    CheckAccessTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<CheckRefreshTokenUseCase>(
    CheckRefreshTokenUseCase(
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

  sl.registerSingleton<GetAuthenticateBiometrics>(
    GetAuthenticateBiometrics(
      sl<AuthenticationRepository>(),
    ),
  );
}

Future<void> _initBlog() async {
  sl.registerSingleton<BlogRemoteDataSrc>(
    BlogRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<BlogRepository>(
    BlogRepositoryImpl(
      sl<BlogRemoteDataSrc>(),
    ),
  );

  sl.registerSingleton<GetBlogsUseCase>(
    GetBlogsUseCase(
      sl<BlogRepository>(),
    ),
  );
}

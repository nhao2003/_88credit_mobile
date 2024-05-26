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
  await _initPost();
  await _initMedia();
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

Future<void> _initPost() async {
  // datasource
  sl.registerSingleton<PostRemoteDataSrc>(
    PostRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  // sl.registerSingleton<MediaRemoteDataSource>(
  //   MediaRemoteDataSourceImpl(
  //     sl<Dio>(),
  //   ),
  // );
  // post repository
  sl.registerSingleton<PostRepository>(
    PostRepositoryImpl(
      sl<PostRemoteDataSrc>(),
    ),
  );

  // sl.registerSingleton<MediaRepository>(
  //   MediaRepositoryImpl(
  //     sl<MediaRemoteDataSource>(),
  //   ),
  // );

  // use cases
  sl.registerSingleton<GetPostsUseCase>(
    GetPostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<CreatePostsUseCase>(
    CreatePostsUseCase(
      sl<PostRepository>(),
    ),
  );

  // sl.registerSingleton<GetPostsLendingUseCase>(
  //   GetPostsLendingUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<GetPostsBorrowingUseCase>(
  //   GetPostsBorrowingUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<GetPostsApprovedUseCase>(
  //   GetPostsApprovedUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<GetPostsPendingUseCase>(
  //   GetPostsPendingUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<GetPostsRejectUseCase>(
  //   GetPostsRejectUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<GetPostsHidedUseCase>(
  //   GetPostsHidedUseCase(
  //     sl<PostRepository>(),
  //   ),
  // );

  // sl.registerSingleton<UploadImagesUseCase>(
  //   UploadImagesUseCase(
  //     sl<MediaRepository>(),
  //   ),
  // );

  // sl.registerSingleton<UploadVideosUseCase>(
  //   UploadVideosUseCase(
  //     sl<MediaRepository>(),
  //   ),
  // );
}

Future _initMedia() async {
  // datasource
  sl.registerSingleton<MediaRemoteDataSource>(
    MediaRemoteDataSourceImpl(
      sl<Dio>(),
    ),
  );
  sl.registerSingleton<MediaRepository>(
    MediaRepositoryImpl(
      sl<MediaRemoteDataSource>(),
    ),
  );
  sl.registerSingleton<UploadImagesUseCase>(
    UploadImagesUseCase(
      sl<MediaRepository>(),
    ),
  );

  sl.registerSingleton<UploadVideosUseCase>(
    UploadVideosUseCase(
      sl<MediaRepository>(),
    ),
  );
}

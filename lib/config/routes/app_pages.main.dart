part of 'app_pages.dart';

class MyAppPages extends AppPages {
  @override
  List<PageEntity> pages() {
    return [
      PageEntity(
        path: AppRoutes.splash,
        page: const SplashScreen(),
        bloc: null,
      ),
      PageEntity(
        path: AppRoutes.login,
        page: const LoginScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      ),
      PageEntity(
        path: AppRoutes.register,
        page: const RegisterScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      ),
      PageEntity(
        path: AppRoutes.fogot,
        page: const ForgotPasswordScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      ),
      PageEntity(
        path: AppRoutes.resetPassword,
        page: const UpdatePasswordScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      ),
      PageEntity(
        path: AppRoutes.updateInfo,
        page: const UpdateInfoScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      ),
      PageEntity(
        path: AppRoutes.bottomBar,
        page: const BottomBarScreen(),
        bloc: BlocProvider(create: (context) => BarBloc()),
      ),
      PageEntity(
        path: AppRoutes.home,
        page: const HomeScreen(),
        bloc: BlocProvider(create: (context) => HomeBloc()),
      ),
      PageEntity(
        path: AppRoutes.blog,
        page: const BlogListScreen(),
        bloc: BlocProvider(create: (context) => BlogBloc()),
      ),
      PageEntity(
        path: AppRoutes.blogDetail,
        page: const BlogDetailScreen(),
        bloc: BlocProvider(create: (context) => BlogBloc()),
      ),
      PageEntity(
        path: AppRoutes.post,
        page: const PostScreen(),
        bloc: BlocProvider(create: (context) => PostBloc()),
      ),
      PageEntity(
        path: AppRoutes.postDetail,
        page: PostDetailScreen(),
        bloc: BlocProvider(create: (context) => PostDetailBloc()),
      ),
      PageEntity(
        path: AppRoutes.account,
        page: const AccountScreen(),
        bloc: BlocProvider(create: (context) => AccountBloc()),
      ),
      PageEntity(
        path: AppRoutes.createPost,
        page: CreatePostScreen(),
        bloc: BlocProvider(create: (context) => CreatePostBloc()),
      ),
      PageEntity(
        path: AppRoutes.contract,
        page: const ContractScreen(),
        bloc: BlocProvider(create: (context) => ContractBloc()),
      ),
      PageEntity(
        path: AppRoutes.request,
        page: const RequestTabScreen(),
        bloc: BlocProvider(create: (context) => RequestBloc()),
      ),
      PageEntity(
        path: AppRoutes.requestDetail,
        page: const RequestDetailScreen(),
        bloc: BlocProvider(create: (context) => RequestDetailBloc()),
      ),
      PageEntity(
        path: AppRoutes.createRequest,
        page: const CreateRequestScreen(),
        bloc: BlocProvider(create: (context) => CreateRequestBloc()),
      ),
      PageEntity(
        path: AppRoutes.contractDetail,
        page: const ContractDetailScreen(),
        bloc: BlocProvider(create: (context) => ContractBloc()),
      ),
      PageEntity(
        path: AppRoutes.userProfile,
        page: const UserProfileScreen(),
        bloc: BlocProvider(create: (context) => UserProfileBloc()),
      ),
      PageEntity(
        path: AppRoutes.generateQRCode,
        page: const GenerateCodeScreen(),
        bloc: BlocProvider(create: (context) => QrCodeBloc()),
      ),
      PageEntity(
        path: AppRoutes.scanQRCode,
        page: const ScanCodeScreen(),
        bloc: BlocProvider(create: (context) => QrCodeBloc()),
      ),
      PageEntity(
        path: AppRoutes.chatBot,
        page: const ChatBotScreen(),
        bloc: BlocProvider(create: (context) => ChatBotBloc()),
      ),
      PageEntity(
        path: AppRoutes.loginCall,
        page: const LoginCallScreen(),
        bloc: BlocProvider(create: (context) => CallBloc()),
      ),
      PageEntity(
        path: AppRoutes.connectCall,
        page: const ConnectScreen(),
        bloc: BlocProvider(create: (context) => CallBloc()),
      ),
      PageEntity(
        path: AppRoutes.callVideo,
        page: const CallVideoPage(),
        bloc: BlocProvider(create: (context) => CallBloc()),
      ),
    ];
  }
}

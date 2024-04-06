import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/features/presentation/modules/account/screens/account_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/bottom_bar/bloc/bar_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/bottom_bar/bottom_bar_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/create_post/bloc/create_post_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/home/bloc/home_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/home/screens/home_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/forgot_password_sceen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/login_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/register_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/update_password_sceen.dart';
import 'package:_88credit_mobile/features/presentation/modules/post/bloc/post_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/post/screens/post_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/post_detail/bloc/post_detail_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/post_detail/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/presentation/modules/account/bloc/account_bloc.dart';
import '../../features/presentation/modules/create_post/screens/create_post_screen.dart';
import '../../features/presentation/modules/error/screens/error_screen.dart';
import '../../features/presentation/modules/login/bloc/auth_bloc.dart';
import '../../features/presentation/modules/login/screens/update_info_screen.dart';

class AppPages {
  static List<PageEntity> pages() {
    return [
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
    ];
  }

  static final RouteObserver<Route> routeObserver = RouteObserver<Route>();
  static List<String> history = [];

  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = [];
    pages().forEach((element) {
      blocerList.add(element.bloc);
    });
    return blocerList;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = pages().where((element) => element.path == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
          builder: (context) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
      settings: settings,
    );
  }
}

class PageEntity<T> {
  String path;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.path,
    required this.page,
    required this.bloc,
  });
}

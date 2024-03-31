import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/features/presentation/modules/bottom_bar/bloc/bar_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/bottom_bar/bottom_bar_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/home/bloc/home_bloc.dart';
import 'package:_88credit_mobile/features/presentation/modules/home/screens/home_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/forgot_password_sceen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/login_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/register_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/update_password_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        page: HomeScreen(),
        bloc: BlocProvider(create: (context) => HomeBloc()),
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
      builder: (context) => const LoginScreen(),
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

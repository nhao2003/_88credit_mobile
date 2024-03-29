import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/features/presentation/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/presentation/modules/login/bloc/auth_bloc.dart';

class AppPages {
  static final RouteObserver<Route> routeObserver = RouteObserver<Route>();
  static List<String> history = [];

  static List<PageEntity> pages() {
    return [
      PageEntity(
        path: AppRoutes.login,
        page: const LoginScreen(),
        bloc: BlocProvider(create: (context) => AuthBloc()),
      )
    ];
  }

  static List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = [];
    pages().forEach((element) {
      blocerList.add(element.bloc);
    });
    return blocerList;
  }

  static GoRouter router() {
    List<GoRoute> routes = [];
    pages().forEach((element) {
      routes.add(GoRoute(
        path: element.path,
        builder: (context, state) => element.page,
      ));
    });
    return GoRouter(
      routes: routes,
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

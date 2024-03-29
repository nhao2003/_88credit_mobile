import 'package:_88credit_mobile/features/presentation/modules/base/screens/base1_screen.dart';
import 'package:_88credit_mobile/features/presentation/modules/base/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPages {
  static var router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BaseScreen(),
      ),
      GoRoute(
        path: '/base2',
        builder: (context, state) => const Base2Screen(),
      ),
    ],
  );
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

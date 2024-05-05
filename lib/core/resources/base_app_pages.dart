import 'package:flutter/material.dart';

import '../../features/presentation/modules/error/screens/error_screen.dart';

abstract class BaseAppPages {
  List<PageEntity> pages();
}

class AppPages extends BaseAppPages {
  @override
  List<PageEntity> pages() {
    return [];
  }

  final RouteObserver<Route> routeObserver = RouteObserver<Route>();
  List<String> history = [];

  List<dynamic> blocer(BuildContext context) {
    List<dynamic> blocerList = [];
    pages().forEach((element) {
      blocerList.add(element.bloc);
    });
    return blocerList;
  }

  MaterialPageRoute generateRouteSettings(RouteSettings settings) {
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

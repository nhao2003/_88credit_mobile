import 'package:_88credit_mobile/config/routes/app_pages.dart';
import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_theme.dart';
import 'package:_88credit_mobile/config/values/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // khong cho man hinh xoay ngang
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [...AppPages.blocer(context)],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(),
        navigatorObservers: [AppPages.routeObserver],
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppPages.generateRouteSettings,
      ),
    );
  }
}

import 'package:_88credit_mobile/config/routes/app_pages.dart';
import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_theme.dart';
import 'package:_88credit_mobile/config/values/app_string.dart';
import 'package:_88credit_mobile/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await dotenv.load(fileName: envPath);
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
    final appPages = sl<MyAppPages>();

    return MultiBlocProvider(
      providers: [...appPages.blocer(context)],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(),
        navigatorObservers: [appPages.routeObserver],
        initialRoute: AppRoutes.splash,
        onGenerateRoute: appPages.generateRouteSettings,
      ),
    );
  }
}

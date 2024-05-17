import 'package:flutter/material.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/values/asset_image.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../di/injection_container.dart';
import '../../../domain/usecases/authentication/check_access_token.dart';
import '../../../domain/usecases/authentication/check_refresh_token.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> _checkIsLogin() async {
    try {
      // check access token
      CheckAccessTokenUseCase checkTokenUseCase = sl<CheckAccessTokenUseCase>();
      final dataState = await checkTokenUseCase();
      if (dataState is DataSuccess && dataState.data == true) return true;

      // check Refresh token
      CheckRefreshTokenUseCase checkRefreshTokenUseCase =
          sl<CheckRefreshTokenUseCase>();
      final dataStateRefresh = await checkRefreshTokenUseCase();
      if (!(dataStateRefresh is DataSuccess && dataStateRefresh.data == true)) {
        return false;
      }
      // refresh access token

      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void checkLogin(BuildContext context) {
    _checkIsLogin().then((value) {
      if (value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.bottomBar,
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.login,
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Đặt căn giữa theo chiều dọc
          mainAxisSize:
              MainAxisSize.min, // Chỉ mở rộng theo chiều dọc nếu cần thiết
          children: [
            Image.asset(Assets.appLogoLight),
            const SizedBox(
                height: 16), // Khoảng cách giữa hình ảnh và vòng tròn
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

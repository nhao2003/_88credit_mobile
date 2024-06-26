import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/di/injection_container.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/authentication/check_refresh_token.dart';
import '../../../../domain/usecases/authentication/get_authen_biometrics.dart';

class FingerprintButton extends StatelessWidget {
  FingerprintButton({super.key});

  final GetAuthenticateBiometrics getAuthenticateBiometrics =
      sl<GetAuthenticateBiometrics>();

  @override
  Widget build(BuildContext context) => buildAuthenticate(context);

  Widget buildAuthenticate(BuildContext context) => buildButton(
        icon: Icons.fingerprint,
        onClicked: () async {
          final isAuthenticated = await getAuthenticateBiometrics();

          if (isAuthenticated) {
            // check Refresh token
            CheckRefreshTokenUseCase checkRefreshTokenUseCase =
                sl<CheckRefreshTokenUseCase>();
            final dataStateRefresh = await checkRefreshTokenUseCase();
            if (!(dataStateRefresh is DataSuccess &&
                dataStateRefresh.data == true)) {
              if (!context.mounted) return;
              context.snackBar('Dấu vân tay không hợp lệ!',
                  type: SnackBarType.error);
              return;
            }

            if (!context.mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomBar,
              (Route<dynamic> route) => false,
            );
            context.snackBar('Đăng nhập thành công!');
          }
        },
      );

  Widget buildButton({
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      Container(
        width: 60,
        margin: const EdgeInsets.only(left: 5),
        child: RawMaterialButton(
          onPressed: onClicked,
          elevation: 10,
          fillColor: AppColors.green,
          padding: const EdgeInsets.all(15.0),
          shape: const CircleBorder(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Icon(
            icon,
            size: 26.0,
            color: Colors.white,
          ),
        ),
      );
}

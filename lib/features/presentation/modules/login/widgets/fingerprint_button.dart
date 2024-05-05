import 'package:_88credit_mobile/config/routes/app_routes.dart';
import 'package:_88credit_mobile/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import '../bloc/local_auth_api.dart';

class FingerprintButton extends StatelessWidget {
  const FingerprintButton({super.key});

  @override
  Widget build(BuildContext context) => buildAuthenticate(context);

  Widget buildAuthenticate(BuildContext context) => buildButton(
        icon: Icons.fingerprint,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            if (!context.mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomBar,
              (Route<dynamic> route) => false,
            );
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

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

extension BuildContextX on BuildContext {
  // Để lấy screen size (context.screenSize)
  Size get screenSize => MediaQuery.of(this).size;

  // Để lấy icon size mặc định (context.iconSize)
  double? get iconSize => IconTheme.of(this).size;

  // Để lấy size của safe area (context.padding)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  // show SnackBar

  void snackBar(String message, {SnackBarType type = SnackBarType.success}) {
    AnimatedSnackBarType animatedSnackBarType = AnimatedSnackBarType.success;
    switch (type) {
      case SnackBarType.success:
        animatedSnackBarType = AnimatedSnackBarType.success;
        break;
      case SnackBarType.error:
        animatedSnackBarType = AnimatedSnackBarType.error;
        break;
      case SnackBarType.warning:
        animatedSnackBarType = AnimatedSnackBarType.warning;
        break;
      case SnackBarType.info:
        animatedSnackBarType = AnimatedSnackBarType.info;
        break;
    }

    return AnimatedSnackBar.material(
      message,
      type: animatedSnackBarType,
      animationDuration: const Duration(milliseconds: 800),
      duration: const Duration(seconds: 2),
      animationCurve: Curves.bounceOut,
    ).show(this);
  }
}

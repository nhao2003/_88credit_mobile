import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  // Để lấy screen size (context.screenSize)
  Size get screenSize => MediaQuery.of(this).size;

  // Để lấy icon size mặc định (context.iconSize)
  double? get iconSize => IconTheme.of(this).size;

  // Để lấy size của safe area (context.padding)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  // show SnackBar

  void snackBar(String message,
      {AnimatedSnackBarType? type = AnimatedSnackBarType.success}) {
    return AnimatedSnackBar.material(
      message,
      type: type ?? AnimatedSnackBarType.success,
      animationDuration: const Duration(milliseconds: 800),
      duration: const Duration(seconds: 2),
      animationCurve: Curves.bounceOut,
    ).show(this);
  }
}

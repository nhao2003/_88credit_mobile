import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/text_styles.dart';

class BaseButton extends StatefulWidget {
  const BaseButton(
      {required this.title,
      this.isLoading,
      this.colorButton,
      this.colorText,
      this.width,
      required this.onClick,
      super.key});

  final bool? isLoading;
  final Color? colorButton;
  final Color? colorText;
  final String title;
  final Function onClick;
  final double? width;

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading!
          ? null
          : () {
              widget.onClick();
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.colorButton ?? AppColors.green,
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(color: AppColors.white),
        elevation: 10,
        minimumSize: Size(widget.width ?? 100.wp, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: widget.isLoading!
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ))
          : Text(
              widget.title,
              style: AppTextStyles.bold14
                  .colorEx(widget.colorText ?? AppColors.white),
            ),
    );
  }
}

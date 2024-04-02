import 'package:flutter/material.dart';

import '../../../../../config/theme/app_color.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  var isLiked = false;

  void toggleIsLiked() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          isLiked ? Icons.bookmark : Icons.bookmark_border_outlined,
          size: 25,
        ),
        color: isLiked ? AppColors.yellow : AppColors.grey400,
        onPressed: () {
          toggleIsLiked();
        },
      ),
    );
  }
}

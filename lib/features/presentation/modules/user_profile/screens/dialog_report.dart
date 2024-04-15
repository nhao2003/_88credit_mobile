import 'dart:io';
import 'package:_88credit_mobile/core/extensions/buildcontext_ex.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../domain/entities/user.dart';
import '../../../globalwidgets/base_button.dart';
import '../../../globalwidgets/base_textfield.dart';
import '../../../globalwidgets/header_title.dart';
import '../../../globalwidgets/picker_images.dart';

// ignore: must_be_immutable
class DialogReport extends StatelessWidget {
  DialogReport({
    required this.user,
    required this.handleReportUser,
    super.key,
  });

  final UserEntity user;
  final Function(UserEntity, String, File) handleReportUser;

  final formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  String reason = "";

  void onCancel(BuildContext context) {
    Navigator.of(context).pop();
    textController.clear();
  }

  void onAccept(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (image == null) {
      context.snackBar(
        "Vui lòng chọn ảnh minh chứng",
        type: AnimatedSnackBarType.error,
      );
      return;
    }
    await handleReportUser(user, reason, image!);
  }

  // images
  bool? photoController;

  // portrait
  File? image;

  final ImagePicker _picker = ImagePicker();

  Future<File> imgFromGallery() async {
    final pickedImages = await _picker.pickImage(source: ImageSource.gallery);
    return File(pickedImages!.path);
  }

  Future<File> imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    } else {
      return File('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderTitle(
                  title: "Báo cáo người dùng",
                  paddingLeft: 0,
                ),
                const SizedBox(height: 20),
                BaseTextField(
                  minLines: 3,
                  maxLines: 10,
                  maxLength: 1000,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: textController,
                  labelText: 'Lý do báo cáo',
                  hintText: 'Mô tả lý do báo cáo',
                  onSaved: (value) {
                    reason = value!;
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'Mô tả không được rỗng',
                ),
                const HeaderTitle(
                  title: "Ảnh minh chứng",
                  paddingLeft: 0,
                ),
                const SizedBox(height: 10),
                PickerImage(
                  imageFile: image,
                  deleteFile: () {
                    image = null;
                  },
                  imgFromCamera: () {
                    imgFromCamera().then((value) {
                      image = value;
                    });
                  },
                  imgFromGallery: () {
                    imgFromGallery().then((value) {
                      image = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseButton(
                      title: "Hủy",
                      colorButton: AppColors.red,
                      width: 33.wp,
                      isLoading: false,
                      onClick: onCancel,
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      title: "Báo cáo",
                      width: 33.wp,
                      isLoading: false,
                      onClick: onAccept,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

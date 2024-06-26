import 'dart:io';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../../core/service/device_service.dart';

// ignore: must_be_immutable
class ImageAvatarPicker extends StatefulWidget {
  File? imageAvatar; // file image of user
  ImageAvatarPicker({required this.imageAvatar, super.key});
  @override
  State<ImageAvatarPicker> createState() => _ImageAvatarPickerState();
}

class _ImageAvatarPickerState extends State<ImageAvatarPicker> {
  /// get image from camera
  Future<void> getImageFromCamera() async {
    final image = await DeviceService.pickImage(ImageSource.camera);
    if (image == null) return;
    widget.imageAvatar = image;
    if (mounted) Navigator.of(context).pop();
  }

  /// get image from gallery
  Future<void> getImageFromGallery() async {
    final image = await DeviceService.pickImage(ImageSource.gallery);
    if (image == null) return;
    widget.imageAvatar = image;
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> showImageSoure(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                await getImageFromCamera();
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () async {
                await getImageFromGallery();
                setState(() {});
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(AppColors.green),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return buildCircle(
      color: AppColors.green,
      all: 1,
      child: buildCircle(
        color: Colors.white,
        all: 1,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // click on the image
                await showImageSoure(context);
              },
              child: showFace(),
            ),
          ),
        ),
      ),
    );
  }

  Widget showFace() {
    int imageSize = 30;
    if (widget.imageAvatar != null) {
      return Image.file(
        widget.imageAvatar!,
        fit: BoxFit.cover,
        width: imageSize.wp,
        height: imageSize.wp,
      );
    } else {
      return SizedBox(
        width: imageSize.wp,
        height: imageSize.wp,
        child: Image.asset(
          Assets.avatarDefault,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 2,
      child: buildCircle(
        color: color,
        all: 5,
        child: InkWell(
          onTap: () async {
            // click on the image
            await showImageSoure(context);
          },
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}

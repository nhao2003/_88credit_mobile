import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:_88credit_mobile/config/theme/text_styles.dart';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/values/asset_image.dart';

// ignore: must_be_immutable
class PickerImage extends StatefulWidget {
  PickerImage({
    required this.imageFile,
    required this.imgFromGallery,
    required this.imgFromCamera,
    super.key,
  });

  File? imageFile;
  final Function imgFromGallery;
  final Function imgFromCamera;

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> {
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              const SizedBox(height: 50),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Thư viện"),
                onTap: () {
                  widget.imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Máy ảnh"),
                onTap: () {
                  widget.imgFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightImage = 50.wp;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          strokeWidth: 1,
          dashPattern: const [5, 2],
          color: AppColors.green,
          child: widget.imageFile == null
              ? Container(
                  height: heightImage,
                  color: AppColors.white,
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            height: 100,
                            width: 100,
                            image: AssetImage(Assets.addPhoto),
                          ),
                          Text(
                            "Thêm ảnh",
                            style:
                                AppTextStyles.bold14.colorEx(AppColors.grey400),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  color: AppColors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: heightImage,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(
                              File(widget.imageFile!.path),
                              fit: BoxFit.cover,
                              height: heightImage,
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: AppColors.green,
                                ),
                                onPressed: () {
                                  widget.imageFile = null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:_88credit_mobile/core/extensions/double_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/enums/type_indetification_document.dart';
import '../bloc/verification_bloc.dart';

class ChooseImage extends StatefulWidget {
  final bool typeImage;
  const ChooseImage(this.typeImage, {super.key});

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  String getAssetImage(TypeIndetificationDocument type) {
    if (widget.typeImage) {
      // mat truoc
      switch (type) {
        case TypeIndetificationDocument.canCuocCongDan:
          return Assets.cccdFront;
        case TypeIndetificationDocument.chungMinhNhanDan:
          return Assets.cmndFront;
        case TypeIndetificationDocument.hoChieu:
          return Assets.hochieuFront;
      }
    } else {
      switch (type) {
        case TypeIndetificationDocument.canCuocCongDan:
          return Assets.cccdBack;
        case TypeIndetificationDocument.chungMinhNhanDan:
          return Assets.cmndBack;
        case TypeIndetificationDocument.hoChieu:
          return Assets.hochieuBack;
      }
    }
  }

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

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
                  imgFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Máy ảnh"),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> handelUploadIdCard(File file, bool isFront) async {
    if (isFront) {
      context.read<VerificationBloc>().add(UploadFrontCardFile(file, isFront));
    } else {
      context.read<VerificationBloc>().add(UploadBackCardFile(file, isFront));
    }
  }

  void _pickImageFromCamera() async {
    final pickedImageFile = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 60, maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      handelUploadIdCard(File(_pickedImage!.path), widget.typeImage);
      setState(() {});
    }
  }

  bool checkIsLoading(VerificationState state) {
    if (widget.typeImage) {
      print("uploadCardFrontStatus: ${state.uploadCardFrontStatus}");
      return state.uploadCardFrontStatus == UploadCardFrontStatus.loading;
    } else {
      print("uploadCardBackStatus: ${state.uploadCardBackStatus}");
      return state.uploadCardBackStatus == UploadCardBackStatus.loading;
    }
  }

  void imgFromGallery() async {
    final pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      handelUploadIdCard(File(_pickedImage!.path), widget.typeImage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 50.0.wp,
      child: Column(
        children: [
          BlocBuilder<VerificationBloc, VerificationState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    height: 130,
                    width: double.infinity,
                    child: _pickedImage != null
                        ? Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            fit: BoxFit.cover,
                            getAssetImage(state.typeIndetificationDocument),
                          ),
                  ),
                  // loading center image
                  if (checkIsLoading(state))
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          BlocBuilder<VerificationBloc, VerificationState>(
            builder: (context, state) {
              return InkWell(
                onTap:
                    checkIsLoading(state) ? null : () => _showPicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: checkIsLoading(state)
                        ? AppColors.grey500
                        : AppColors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.typeImage ? "Chụp mặt trước" : "Chụp mặt sau",
                          style: AppTextStyles.bold14
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

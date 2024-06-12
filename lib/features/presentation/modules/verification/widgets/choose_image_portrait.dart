import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../bloc/verification_bloc.dart';

class ChooseImagePortrait extends StatefulWidget {
  const ChooseImagePortrait({super.key});

  @override
  State<ChooseImagePortrait> createState() => _ChooseImagePortraitState();
}

class _ChooseImagePortraitState extends State<ChooseImagePortrait> {
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

  Future<void> handelUploadPortrait(File file) async {
    context.read<VerificationBloc>().add(UploadPortrait(file));
  }

  void _pickImageFromCamera() async {
    final pickedImageFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100,
        maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      handelUploadPortrait(File(_pickedImage!.path));
      setState(() {});
    }
  }

  void imgFromGallery() async {
    final pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      handelUploadPortrait(File(_pickedImage!.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          return Stack(
            children: [
              DottedBorder(
                color: state.urlImagePortrait.isNotEmpty
                    ? Colors.white
                    : AppColors.green,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                dashPattern: const [8, 4],
                radius: const Radius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(
                      state.urlImagePortrait.isNotEmpty ? 0 : 10),
                  height: 200,
                  width: 150,
                  child: _pickedImage != null
                      ? Image.file(
                          _pickedImage!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          fit: BoxFit.cover,
                          Assets.portrait,
                        ),
                ),
              ),

              // loading center image
              if (state.uploadPortraitstatus == UploadPortraitstatus.loading)
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
      const SizedBox(height: 15),
      BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          return InkWell(
            onTap: state.uploadPortraitstatus == UploadPortraitstatus.loading
                ? null
                : () => _showPicker(context),
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color:
                    state.uploadPortraitstatus == UploadPortraitstatus.loading
                        ? AppColors.grey300
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
                      "Chụp ảnh",
                      style:
                          AppTextStyles.bold14.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ]);
  }
}

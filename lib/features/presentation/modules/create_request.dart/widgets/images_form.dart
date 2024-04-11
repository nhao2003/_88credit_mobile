import 'dart:io';

import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../globalwidgets/picker_images.dart';
import '../../../globalwidgets/picker_video.dart';
import '../bloc/create_request_bloc.dart';

class ImagesForm extends StatelessWidget {
  final bool isvisible;

  ImagesForm({required this.isvisible, super.key});

  // hinh anh

  // portrait
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

  // video
  Future<File> videoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickVideo(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    } else {
      return File('');
    }
  }

  Future<File> videoFromGallery() async {
    final pickedImages = await _picker.pickVideo(source: ImageSource.gallery);
    return File(pickedImages!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isvisible,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: BlocBuilder<CreateRequestBloc, CreateRequestState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ảnh chân dung",
                  style: AppTextStyles.bold14.colorEx(Colors.black),
                ),
                const SizedBox(height: 10),
                PickerImage(
                  imageFile: state.portrait,
                  imgFromCamera: () {
                    imgFromCamera().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangePortrait(value),
                          );
                    });
                  },
                  imgFromGallery: () {
                    imgFromGallery().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangePortrait(value),
                          );
                    });
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Ảnh CCCD mặt trước",
                  style: AppTextStyles.bold14.colorEx(Colors.black),
                ),
                const SizedBox(height: 10),
                PickerImage(
                  imageFile: state.idCardFrontPhoto,
                  imgFromCamera: () {
                    imgFromCamera().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeIdCardFrontPhoto(value),
                          );
                    });
                  },
                  imgFromGallery: () {
                    imgFromGallery().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeIdCardFrontPhoto(value),
                          );
                    });
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  "Ảnh CCCD mặt sau",
                  style: AppTextStyles.bold14.colorEx(Colors.black),
                ),
                const SizedBox(height: 10),
                PickerImage(
                  imageFile: state.idCardBackPhoto,
                  imgFromCamera: () {
                    imgFromCamera().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeIdCardBackPhoto(value),
                          );
                    });
                  },
                  imgFromGallery: () {
                    imgFromGallery().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeIdCardBackPhoto(value),
                          );
                    });
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  "Video minh chứng",
                  style: AppTextStyles.bold14.colorEx(Colors.black),
                ),
                const SizedBox(height: 10),
                PickerVideo(
                  videoFile: state.video,
                  videoFromCamera: () async {
                    await videoFromCamera().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeVideo(value),
                          );
                    });
                  },
                  videoFromGallery: () async {
                    await videoFromGallery().then((value) {
                      context.read<CreateRequestBloc>().add(
                            ChangeVideo(value),
                          );
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

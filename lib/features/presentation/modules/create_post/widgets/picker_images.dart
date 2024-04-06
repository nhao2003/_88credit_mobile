import 'dart:io';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../bloc/create_post_bloc.dart';

class PickerImages extends StatelessWidget {
  PickerImages({super.key});

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
                  imgFromGallery(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Máy ảnh"),
                onTap: () {
                  imgFromCamera(context);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future imgFromGallery(BuildContext context) async {
    final pickedImages = await _picker.pickMultiImage();
    for (int i = 0; i < pickedImages.length; i++) {
      if (!context.mounted) return;
      doEvent(context, AddFileImageEvent(File(pickedImages[i].path)));
    }
    if (!context.mounted) return;
    doEvent(context, CheckLengthPhoto());
  }

  Future imgFromCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null && !context.mounted) return;
    doEvent(context, AddFileImageEvent(File(image!.path)));
    doEvent(context, CheckLengthPhoto());
  }

  void deleteImage(int index, BuildContext context) {
    doEvent(context, RemoveFileImageEvent(index));
    doEvent(context, CheckLengthPhoto());
  }

  void doEvent(BuildContext context, CreatePostEvent event) {
    context.read<CreatePostBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    double heightImage = 50.wp;

    return BlocBuilder<CreatePostBloc, CreatePostState>(
      builder: (context, state) {
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
              color:
                  state.photoController == false ? Colors.red : AppColors.green,
              child: state.photo.isEmpty && state.imageUrlList.isEmpty
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
                                "Thêm từ 3 đến 12 ảnh",
                                style: AppTextStyles.bold14
                                    .colorEx(AppColors.grey400),
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
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.imageUrlList.length +
                                  1 +
                                  state.photo.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: heightImage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: AppColors.white),
                                    child: index == 0
                                        ? GestureDetector(
                                            onTap: () {
                                              _showPicker(context);
                                              //imgFromGallery();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              // width: MediaQuery.of(context).size.width - 20.w,
                                              height: 80,
                                              width: 80,
                                              child: const Image(
                                                image:
                                                    AssetImage(Assets.addPhoto),
                                              ),
                                            ),
                                          )
                                        : Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              state.imageUrlList.isNotEmpty &&
                                                      index <=
                                                          state.imageUrlList
                                                              .length
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          state.imageUrlList[
                                                              index - 1],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(
                                                      File(state
                                                          .photo[index -
                                                              state.imageUrlList
                                                                  .length -
                                                              1]
                                                          .path),
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
                                                    deleteImage(
                                                        index - 1, context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: state.photoController == false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Số lượng hình ảnh từ 3 đến 12 hình",
                    style: AppTextStyles.regular14.colorEx(AppColors.red),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

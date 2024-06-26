import 'dart:io';
import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:_88credit_mobile/core/extensions/textstyle_ex.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/values/asset_image.dart';

// ignore: must_be_immutable
class PickerVideo extends StatefulWidget {
  PickerVideo({
    required this.videoFile,
    required this.videoFromGallery,
    required this.videoFromCamera,
    required this.deleteFile,
    super.key,
  });

  File? videoFile;
  final Future<void> Function() videoFromGallery;
  final Future<void> Function() videoFromCamera;
  final Function deleteFile;

  @override
  State<PickerVideo> createState() => _PickerVideoState();
}

class _PickerVideoState extends State<PickerVideo> {
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void initVideoController() {
    if (widget.videoFile == null) return;
    _controller = VideoPlayerController.file(File(widget.videoFile!.path));

    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.setLooping(true);
    _controller?.initialize().then((_) => setState(() {}));
    _controller?.play();
  }

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
                onTap: () async {
                  await widget.videoFromGallery();
                  initVideoController();
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Máy ảnh"),
                onTap: () async {
                  await widget.videoFromCamera();
                  initVideoController();
                  if (!context.mounted) return;
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
          child: widget.videoFile == null
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
                            image: AssetImage(Assets.addVideo),
                          ),
                          Text(
                            "Thêm video",
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
                            // Image.file(
                            //   File(widget.videoFile!.path),
                            //   fit: BoxFit.cover,
                            //   height: heightImage,
                            // ),
                            if (_controller != null)
                              AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    VideoPlayer(_controller!),
                                    _ControlsOverlay(controller: _controller!),
                                    VideoProgressIndicator(_controller!,
                                        allowScrubbing: true),
                                  ],
                                ),
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
                                  // widget.videoFile = null;
                                  widget.deleteFile();
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

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

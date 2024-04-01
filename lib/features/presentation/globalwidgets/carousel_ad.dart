import 'package:_88credit_mobile/core/extensions/integer_ex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/values/asset_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/advertisement.dart';

class CarouselAd extends StatefulWidget {
  const CarouselAd(
      {super.key,
      required this.imgList,
      required this.aspectRatio,
      required this.indicatorSize});

  final List<AdvertisementEnity> imgList;
  final double aspectRatio;
  final double indicatorSize;

  @override
  State<CarouselAd> createState() => _CarouselAdState();
}

class _CarouselAdState extends State<CarouselAd> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      children: [
        CarouselSlider(
          items: widget.imgList
              .map((item) => GestureDetector(
                    onTap: () {
                      launchWebURL(item.link);
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: item.thumbnail,
                        fit: BoxFit.cover,
                        width: 100.wp,
                        errorWidget: (context, _, __) {
                          return Image.asset(
                            Assets.defaultImage,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ))
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: widget.aspectRatio,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: widget.indicatorSize,
                  height: widget.indicatorSize,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ));
  }
}

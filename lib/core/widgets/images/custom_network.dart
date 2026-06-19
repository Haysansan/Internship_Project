import 'package:apploan/flavor/app_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/main.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  String get _resolvedUrl {
    if (imageUrl.startsWith('http')) return imageUrl;
    final base = AppConfig.shared.baseUrl.replaceAll(RegExp(r'/api(/.*)?$'), '');
    return '$base$imageUrl';
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _resolvedUrl,
      width: width ?? Get.width,
      height: height ?? Get.height,
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 200),
      fit: BoxFit.cover,
      errorWidget: (_, error, test) {
        customPrint('Failed to load network image $_resolvedUrl');
        return _defaultImage();
      },
      placeholder: (_, __) {
        return _defaultImage();
      },
    );
  }

  Widget _defaultImage() {
    return Image.asset(
      AssetPath.placeholder.path,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}

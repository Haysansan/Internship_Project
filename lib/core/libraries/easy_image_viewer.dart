import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class EasyImageViewerManager extends EasyImageProvider {
  final List<String> urls;
  @override
  final int initialIndex;

  EasyImageViewerManager({required this.urls, this.initialIndex = 0});

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    String? url = urls[index];

    ImageProvider imageProvider = NetworkImage(url);

    return imageProvider;
  }

  @override
  int get imageCount => urls.length;
}

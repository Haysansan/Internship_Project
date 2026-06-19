import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apploan/core/core.dart';

class ImagePickerManager {
  static final ImagePicker _picker = ImagePicker();

  static void pickImage(Function(XFile?) result) {
    final context = UserRepository.shared.context!;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: UIConstants.radius.radiusAll),
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: 8.padTop,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Library
                ListTile(
                  title: Text(LocaleKeys.photoLibrary.tr),
                  leading: const Icon(Icons.photo_library),
                  onTap: () => _handlePick(context, result: result, isGallery: true),
                ),

                const Divider(),

                // Camera
                ListTile(
                  title: Text(LocaleKeys.camera.tr),
                  leading: const Icon(Icons.camera),
                  onTap: () => _handlePick(context, result: result),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _handlePick(
    BuildContext context, {
    required Function(XFile?) result,
    bool isGallery = false,
  }) async {
    Navigator.of(context).pop();
    try {
      final XFile? image = await _picker.pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500,
      );
      result(image);
    } catch (e) {
      ExceptionHandler.handleException(LocaleKeys.unableToPickImagePleaseTryAgain.tr);
    }
  }
}

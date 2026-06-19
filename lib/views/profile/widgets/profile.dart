import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key}) : super(key: key);

  final ProfileController profilCtl = Get.find<ProfileController>();

  void updateProfile() async {
    ImagePickerManager.pickImage((file) async {
      if (file != null) {
        await profilCtl.updateProfile(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                17.height,
                InkWell(
                  onTap: () => updateProfile(),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColor.grey, width: 1.2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Obx(
                            () {
                              if ((profilCtl.profile.value?.path ?? '').isEmpty) {
                                return CustomNetworkImage(
                                  imageUrl: UserRepository.shared.profile.profile,
                                  width: 120,
                                  height: 120,
                                );
                              }
                              return Image.file(
                                File(profilCtl.profile.value!.path),
                                width: 120,
                                height: 120,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColor.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.height,
                Text(
                  UserRepository.shared.profile.name,
                  style: AppTextStyle.extraHugeBlackSemiBold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

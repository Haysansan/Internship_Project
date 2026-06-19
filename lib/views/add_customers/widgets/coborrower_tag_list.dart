import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/views/views.dart';

class CoBorrowerTagList extends StatelessWidget {
  const CoBorrowerTagList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CoBorrowerController>();
    return Obx(() {
      if (controller.added.isEmpty) return const SizedBox.shrink();
      return _TagWrap(
        names: controller.added.map((e) => e.fullname).toList(),
        onRemove: controller.remove,
      );
    });
  }
}

class GuarantorTagList extends StatelessWidget {
  const GuarantorTagList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GuarantorController>();
    return Obx(() {
      if (controller.added.isEmpty) return const SizedBox.shrink();
      return _TagWrap(
        names: controller.added.map((e) => e.fullname).toList(),
        onRemove: controller.remove,
      );
    });
  }
}

class _TagWrap extends StatelessWidget {
  const _TagWrap({required this.names, required this.onRemove});

  final List<String> names;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          names.asMap().entries.map((entry) {
            return Chip(
              label: Text(entry.value, style: AppTextStyle.smallGreyRegular),
              deleteIcon: const Icon(Icons.close, size: 14),
              onDeleted: () => onRemove(entry.key),
              backgroundColor: Colors.white,
              side: const BorderSide(color: AppColor.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }).toList(),
    );
  }
}

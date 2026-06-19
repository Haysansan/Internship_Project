import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onClear,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClear;
  final ValueChanged<String> onSubmitted;

  void _submit() {
    final text = controller.text;
    if (text.isEmpty) {
      onClear();
    } else {
      onSubmitted(text);
    }
  }

  void _clear() {
    if (controller.text.isEmpty) return;
    controller.clear();
    onClear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      filled: true,
      hintText: hintText,
      prefixIcon: Semantics(
        button: true,
        label: LocaleKeys.search.tr,
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: _submit,
            child: const Padding(
              padding: EdgeInsets.all(11),
              child: Icon(
                Icons.search_rounded,
                color: AppColor.primary,
                size: 22,
              ),
            ),
          ),
        ),
      ),
      suffixIcon: Semantics(
        button: true,
        label: LocaleKeys.clear.tr,
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: _clear,
            child: const Padding(
              padding: EdgeInsets.all(11),
              child: Icon(
                Icons.refresh_rounded,
                color: AppColor.primary,
                size: 22,
              ),
            ),
          ),
        ),
      ),
      onFieldSubmitted: (_) => _submit(),
    );
  }
}

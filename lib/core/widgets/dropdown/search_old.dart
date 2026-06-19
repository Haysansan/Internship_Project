import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';

class SearchDropDown<T> extends StatefulWidget {
  const SearchDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final List<dynamic> items;
  final Function(T) onChanged;

  @override
  State<SearchDropDown> createState() => _SearchDropDownState();
}

class _SearchDropDownState<T> extends State<SearchDropDown> {
  T? selectedValue;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Text(LocaleKeys.choose.tr, style: AppTextStyle.normalLightGreyRegular),
        items: widget.items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() => selectedValue = value);
          widget.onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
          height: 47,
          decoration: BoxDecoration(
            borderRadius: UIConstants.radius.radiusAll,
            color: AppColor.white,
            border: Border.all(
              color: AppColor.lightGrey,
              width: 1,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColor.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(height: 47),
        dropdownSearchData: DropdownSearchData(
          searchController: controller,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: CustomTextField(
              controller: controller,
              hintText: 'Search',
            ),
          ),
          searchMatchFn: (item, searchValue) => item.value.toString().contains(searchValue),
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            controller.clear();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:apploan/core/core.dart';

class ApproveTabButton extends StatelessWidget {
  const ApproveTabButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count = 0,
    this.isAlert = false,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int count; // badge number shown on the tab
  final bool isAlert; // red dot when there are unread items

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary : AppColor.white,
            borderRadius: UIConstants.radius.radiusAll,
            border: Border.all(
              color: isSelected ? AppColor.primary : AppColor.lightGrey,
              width: 1.5,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Count badge
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? AppColor.white : AppColor.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Label — wraps on small screens
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color:
                            isSelected
                                ? AppColor.white.withOpacity(0.9)
                                : AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Red alert dot — top-right corner
              if (isAlert)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF008B25),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

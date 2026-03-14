import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';

class WideButton extends StatelessWidget {
  const WideButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color,
      this.icon,
      this.icon2,
      this.textColor = Colors.black54});

  final VoidCallback onTap;
  final String title;
  final Color color;
  final Widget? icon;
  final Widget? icon2;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 55,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: icon ?? SizedBox.shrink(),
                  ),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: AppTextStyles.titleLarge.copyWith(color: textColor),
                  ),
                  icon2 != null ? SizedBox(width: 10) : SizedBox.shrink(),
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: icon2 ?? SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

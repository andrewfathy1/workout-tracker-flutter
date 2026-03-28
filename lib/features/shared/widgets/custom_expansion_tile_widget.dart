import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/shared/widgets/custom_card_element.dart';

class CustomExpansionTileWidget extends StatelessWidget {
  const CustomExpansionTileWidget(
      {super.key, required this.title, required this.children, this.border});

  final String title;
  final List<Widget> children;
  final ShapeBorder? border;
  @override
  Widget build(BuildContext context) {
    return CustomCardElement(
      enableShadow: false,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ExpansionTile(
              shape: border,
              collapsedShape: border,
              title: Center(
                child: Text(
                  title,
                  style: AppTextStyles.titleLarge,
                ),
              ),
              children: children),
        ),
      ),
    );
  }
}

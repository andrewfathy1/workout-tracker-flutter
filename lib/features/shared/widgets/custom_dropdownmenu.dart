import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';

class CustomDropdownmenu extends StatelessWidget {
  const CustomDropdownmenu(
      {super.key,
      required this.onSelected,
      required this.entries,
      required this.hint});
  final void Function(dynamic) onSelected;
  final List<DropdownMenuEntry> entries;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width - 100,
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(26),
          )),
      menuStyle: MenuStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(MediaQuery.of(context).size.width - 100, 300),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: Colors.amber),
        ),
      ),
      hintText: hint,
      textStyle: AppTextStyles.titleLarge.copyWith(color: Colors.white),
      leadingIcon: Icon(Icons.work),
      onSelected: onSelected,
      dropdownMenuEntries: entries,
    );
  }
}

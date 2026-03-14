import 'package:flutter/material.dart';

class SemiTransparentWidget extends StatelessWidget {
  const SemiTransparentWidget({super.key, required this.alpha});
  final int alpha;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'st',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(alpha),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum Dock {
  none,
  dockRight,
  dockLeft,
}

class CustomCardElement extends StatefulWidget {
  const CustomCardElement({
    super.key,
    required this.child,
    this.color = const Color(0xFF1A1D24),
    this.animate = false,
    this.enableShadow = true,
    this.backgroundImagePath,
    this.margin,
    this.padding,
    this.dock = Dock.none,
    this.border,
  });

  final Widget child;
  final Color color;
  final bool animate;
  final bool enableShadow;
  final String? backgroundImagePath;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Dock dock;
  final BoxBorder? border;

  @override
  State<CustomCardElement> createState() => _CustomCardElementState();
}

class _CustomCardElementState extends State<CustomCardElement> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _opacity = 1;
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomCardElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.animate && widget.animate) {
      setState(() => _opacity = 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.animate
        ? AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),
            child: _generateCard(),
          )
        : _generateCard();
  }

  Widget _generateCard() {
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: widget.color,
        image: widget.backgroundImagePath != null
            ? DecorationImage(
                image: AssetImage(widget.backgroundImagePath!),
                fit: BoxFit.contain,
              )
            : null,
        borderRadius: widget.dock == Dock.dockRight
            ? BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              )
            : widget.dock == Dock.dockLeft
                ? BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                : BorderRadius.circular(20),
        border: widget.border,
        boxShadow: widget.enableShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withAlpha(100),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.child,
      ),
    );
  }
//  Widget _generateCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       color: widget.color,
//       elevation: 4,
//       child: widget.child,
//     );
//   }
}

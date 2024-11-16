import 'package:flutter/material.dart';

class AppOutlinedContainer extends StatelessWidget {
  final EdgeInsets margin, padding;
  final Color borderColor;
  final double borderRadius;
  final Widget child;

  const AppOutlinedContainer(this.child,
      {Key? key,
      this.margin = const EdgeInsets.fromLTRB(0, 0, 0, 16),
      this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 12),
      this.borderColor = const Color(0xffD6D6D6),
      this.borderRadius = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor)),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

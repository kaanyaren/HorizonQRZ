import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InstrumentCard extends StatelessWidget {
  final Widget child;
  final Color accentColor;
  final EdgeInsets? padding;

  const InstrumentCard({
    super.key,
    required this.child,
    this.accentColor = const Color(0xFF303E51), // primary
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFC4C6CD), width: 1), // outline-variant
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 0.5.h, color: accentColor),
          Padding(
            padding: padding ?? EdgeInsets.all(4.w),
            child: child,
          ),
        ],
      ),
    );
  }
}

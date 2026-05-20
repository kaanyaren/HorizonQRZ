import 'package:flutter/material.dart';
import '../theme.dart';

class InstrumentCard extends StatelessWidget {
  final Widget child;
  final Color? accentColor;
  final List<Color>? gradientColors;
  final EdgeInsets? padding;

  const InstrumentCard({
    super.key,
    required this.child,
    this.accentColor,
    this.gradientColors,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Beautiful default gradients based on high-tech palette
    final activeGradient = gradientColors ?? [
      accentColor ?? AppTheme.primary,
      (accentColor ?? AppTheme.primary).withOpacity(0.6),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: (accentColor ?? AppTheme.primary).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppTheme.outlineVariant,
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Elegant gradient top border line
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: activeGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Padding(
            padding: padding ?? EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

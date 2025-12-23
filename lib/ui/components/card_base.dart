import 'package:flutter/material.dart';
import 'package:mylob_app/ui/colors.dart';
import 'package:mylob_app/ui/shadows.dart';
import 'package:mylob_app/ui/spacing.dart';

/// CardBase
/// Base card component with consistent styling
class CardBase extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final double? elevation;
  final VoidCallback? onTap;
  final Border? border;

  const CardBase({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.gradient,
    this.borderRadius,
    this.boxShadow,
    this.elevation,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd);
    final effectivePadding = padding ?? const EdgeInsets.all(AppSpacing.cardPadding);
    final effectiveBoxShadow = boxShadow ?? (elevation != null 
        ? (elevation! <= 2 
            ? AppShadows.low 
            : elevation! <= 4 
                ? AppShadows.medium 
                : AppShadows.high)
        : AppShadows.medium);

    final content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? AppColors.surface) : null,
        gradient: gradient,
        borderRadius: effectiveBorderRadius,
        boxShadow: effectiveBoxShadow,
        border: border,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: content,
      );
    }

    return content;
  }
}

/// Predefined card variants
class ElevatedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const ElevatedCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      padding: padding,
      margin: margin,
      onTap: onTap,
      elevation: AppSpacing.elevationMedium,
      child: child,
    );
  }
}

class FlatCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const FlatCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      padding: padding,
      margin: margin,
      onTap: onTap,
      boxShadow: const [],
      backgroundColor: AppColors.surfaceVariant,
      child: child,
    );
  }
}

class OutlinedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? borderColor;

  const OutlinedCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      padding: padding,
      margin: margin,
      onTap: onTap,
      boxShadow: const [],
      backgroundColor: AppColors.surface,
      border: Border.all(
        color: borderColor ?? AppColors.border,
        width: 1,
      ),
      child: child,
    );
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      padding: padding,
      margin: margin,
      onTap: onTap,
      gradient: gradient,
      elevation: AppSpacing.elevationMedium,
      child: child,
    );
  }
}

class InfoCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const InfoCard({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      margin: margin,
      backgroundColor: backgroundColor,
      boxShadow: const [],
      border: borderColor != null 
          ? Border.all(color: borderColor!, width: 1)
          : null,
      child: child,
    );
  }
}

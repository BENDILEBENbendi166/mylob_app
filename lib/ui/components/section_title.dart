import 'package:flutter/material.dart';
import 'package:mylob_app/ui/text_styles.dart';
import 'package:mylob_app/ui/spacing.dart';
import 'package:mylob_app/ui/colors.dart';

/// SectionTitle
/// Consistent section header component
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final IconData? icon;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.padding,
    this.showDivider = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
            vertical: AppSpacing.sm,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: AppSpacing.iconSize,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.headlineSmall,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              if (action != null) action!,
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(),
          ],
        ],
      ),
    );
  }
}

/// Predefined section title variants
class LargeSectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const LargeSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headlineLarge,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class SmallSectionTitle extends StatelessWidget {
  final String title;
  final Widget? action;

  const SmallSectionTitle({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleMedium,
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// See All button for section titles
class SeeAllButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SeeAllButton({
    super.key,
    required this.onPressed,
    this.text = 'See All',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }
}

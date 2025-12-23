import 'package:flutter/material.dart';
import 'package:mylob_app/ui/gradients.dart';
import 'package:mylob_app/ui/spacing.dart';

/// ShimmerBox
/// A reusable shimmer loading component
class ShimmerBox extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.margin,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(AppSpacing.radiusSm),
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                Color(0xFFEBEBF4),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBF4),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// Predefined shimmer shapes
class ShimmerCircle extends StatelessWidget {
  final double size;
  final EdgeInsetsGeometry? margin;

  const ShimmerCircle({
    super.key,
    this.size = 48,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: size,
      height: size,
      margin: margin,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

class ShimmerLine extends StatelessWidget {
  final double? width;
  final double height;
  final EdgeInsetsGeometry? margin;

  const ShimmerLine({
    super.key,
    this.width,
    this.height = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      margin: margin,
      borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? width;
  final double height;
  final EdgeInsetsGeometry? margin;

  const ShimmerCard({
    super.key,
    this.width,
    this.height = 120,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      margin: margin,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    );
  }
}

/// Shimmer list for common loading patterns
class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsetsGeometry? padding;

  const ShimmerList({
    super.key,
    this.itemCount = 3,
    this.itemHeight = 80,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ShimmerCard(
          height: itemHeight,
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
        );
      },
    );
  }
}

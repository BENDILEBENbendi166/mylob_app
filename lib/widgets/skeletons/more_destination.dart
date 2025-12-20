import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoreDestinationSkeleton extends StatelessWidget {
  final int itemCount;
  const MoreDestinationSkeleton({super.key, this.itemCount = 6});

  double _imageHeight(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // ✅ Safe adaptive height for all screens
    return h.clamp(120.0, 180.0);
  }

  int _crossAxisCount(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ✅ Responsive grid
    if (w > 900) return 4; // desktop
    if (w > 600) return 3; // tablet
    return 2; // mobile
  }

  @override
  Widget build(BuildContext context) {
    final imgHeight = _imageHeight(context);
    final crossAxisCount = _crossAxisCount(context);

    return Skeletonizer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Responsive image placeholder
              Container(
                height: imgHeight,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ✅ Title placeholder
              Container(
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 8),

              // ✅ Subtitle placeholder
              Container(
                height: 14,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

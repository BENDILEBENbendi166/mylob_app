import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NowPlayingSkeleton extends StatelessWidget {
  final int itemCount;
  const NowPlayingSkeleton({super.key, this.itemCount = 5});

  double _imageSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ✅ Adaptive image size for mobile/tablet/web
    if (w > 900) return 90; // desktop
    if (w > 600) return 80; // tablet
    return 70; // mobile
  }

  @override
  Widget build(BuildContext context) {
    final imgSize = _imageSize(context);

    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: Container(
                width: imgSize,
                height: imgSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
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
              title: Container(
                height: 20,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              subtitle: Container(
                height: 14,
                width: imgSize * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              trailing: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LinearShimmerLoader extends StatelessWidget {
  const LinearShimmerLoader(
      {super.key,
      required this.height,
      this.width = double.maxFinite,
      this.radius = 8.0,
      this.itemCount = 4,
      this.margin = 12.0});
  final double height;
  final double width;
  final double radius;
  final int itemCount;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < itemCount; i++) _shimmer(context),
      ],
    );
  }

  _shimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(bottom: margin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.grey[300]!,
        ),
      ),
    );
  }
}

class CircleShimmerLoader extends StatelessWidget {
  const CircleShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RectangleShimmerLoader extends StatelessWidget {
  final double? radius;
  const RectangleShimmerLoader({super.key, this.radius = 12.0});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: Colors.white,
        ),
      ),
    );
  }
}

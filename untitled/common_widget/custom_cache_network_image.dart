import 'package:haatinhandseller/common_widget/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCacheNetworkImage extends StatefulWidget {
  final String url;
  final Widget? loader;
  const CustomCacheNetworkImage(
      {super.key,
      required this.url,
      this.loader = const CircleShimmerLoader()});

  @override
  State<CustomCacheNetworkImage> createState() =>
      _CustomCacheNetworkImageState();
}

class _CustomCacheNetworkImageState extends State<CustomCacheNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      height: double.maxFinite,
      width: double.maxFinite,
      fit: BoxFit.fill,
      placeholder: (context, url) => widget.loader!,
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}

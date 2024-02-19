import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../loaders/shimmer_loader.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.bgColor ,
    this.boxFit,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
    this.padding=EdgeInsets.zero,
  });

  final double? width, height;
  final String imageUrl;
  final bool? applyImageRadius;
  final BoxBorder? border;
  final Color? bgColor;
  final BoxFit? boxFit;

  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: bgColor,
            border: border),
        child: ClipRRect(
          borderRadius: applyImageRadius!
              ? BorderRadius.circular(TSizes.md)
              : BorderRadius.zero,
          child:
          isNetworkImage?
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,

            progressIndicatorBuilder: (context, url, progress) =>
             TShimmerLoader(
              width: double.infinity,
              height: 50,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ):
          Image(
            image: AssetImage(imageUrl) as ImageProvider,
            fit: boxFit,
          ),
        ),
      ),
    );
  }
}
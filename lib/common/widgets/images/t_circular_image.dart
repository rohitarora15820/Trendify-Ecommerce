import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width=56,
    this.height=56,
    this.padding=TSizes.sm,
    this.bgColor,
    this.overlayColor,
    this.isNetworkImage=false,
    required this.image,
    this.fit=BoxFit.cover,
  });

  final double width, height, padding;
  final Color? bgColor;
  final Color? overlayColor;
  final bool isNetworkImage;
  final String image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color:bgColor?? (THelperFunctions.isDarkMode(context)
              ? TColors.black
              : TColors.white),
          borderRadius: BorderRadius.circular(100)),
      child: Image(
        image: isNetworkImage ? NetworkImage(image):AssetImage(image) as ImageProvider,
        fit: fit,
        color: overlayColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,

     this.width,
    this.height,
    this.size=TSizes.lg,
   required this.icon,
    this.color,
    this.bgColor,
    this.onPressed,
  });


  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? bgColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: bgColor ?? (dark
                  ? TColors.black.withOpacity(0.9)
                  : TColors.white.withOpacity(0.9)),
          borderRadius: BorderRadius.circular(100)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}

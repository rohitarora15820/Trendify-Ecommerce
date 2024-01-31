import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/text/t_brand_title_text.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class TBrandTitleWithVerifyIcon extends StatelessWidget {
  const TBrandTitleWithVerifyIcon({
    super.key, required this.title, this.maxLines=1, this.textColor, this.iconColor=TColors.primary, this.textAlign=TextAlign.center, this.brandTextSizes=TextSizes.small,
  });


  final String title;
  final int maxLines;
  final Color? textColor,iconColor;
  final TextAlign? textAlign;
  final TextSizes? brandTextSizes;



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
            maxLines: maxLines,

          ),
        ),
        const SizedBox(width: TSizes.xs,),
        const Icon(Iconsax.verify5,color: TColors.primary, size: TSizes.iconXs,)
      ],
    );
  }
}


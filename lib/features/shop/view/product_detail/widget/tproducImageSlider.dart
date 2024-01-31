import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_roundec_images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgesContainer(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Screen Image
            const SizedBox(
                height: 400,
                child: Padding(
                    padding:
                    EdgeInsets.all(TSizes.productImageRadius * 2),
                    child: Center(
                        child: Image(
                          image: AssetImage(TImages.productImage5),
                        )))),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TRoundedImage(
                        width: 80,
                        bgColor: dark ? TColors.dark : TColors.white,
                        border: Border.all(color: TColors.primary),
                        padding: const EdgeInsets.all(TSizes.sm),
                        imageUrl: TImages.productImage3),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    itemCount: 4),
              ),
            ),

            /// AppBar Icons
            TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(dark: dark, icon: Iconsax.heart5,color: Colors.red,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

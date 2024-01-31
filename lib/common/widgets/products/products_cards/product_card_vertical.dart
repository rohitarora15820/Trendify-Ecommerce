import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/styles/shadows.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/common/widgets/images/t_roundec_images.dart';
import 'package:tstore/features/shop/view/product_detail/product_detail.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../icons/t_circular_icon.dart';
import '../../text/t_brand_title_text.dart';
import '../../text/t_product_price_text.dart';
import '../../text/t_product_tile_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: (){
        Get.to(()=> const ProductDetail());
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyles.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.white),
        child: Column(
          children: [
            // Thumbnails, WishList Button & Discount TagTRo
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.md),
              bgColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  ///Thumbnail Image
                  const Center(
                    child: TRoundedImage(
                      imageUrl: TImages.productImage1,
                      applyImageRadius: true,
                    ),
                  ),

                  /// Sales Tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      bgColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: Colors.black),
                      ),
                    ),
                  ),

                  ///Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      dark: dark,
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems/2,
            ),



            ///Detail Section

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TProductTileText(
                  title: 'Grren Nike Air Shoes',
                  smallSize: true,
                ),

                SizedBox(height: TSizes.spaceBtwItems/2,),

                TBrandTitleText(title: 'Nike'),



              ],
            ),
            const Spacer(),

            /// Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left:TSizes.sm),
                  child: TProductPriceText(
                    price: '35.5',
                  ),
                ),

                ///Add To Cart Button
                Container(
                  decoration: const BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      )
                  ),
                  child: const SizedBox(
                      width: TSizes.iconLg * 1.2,
                      height: TSizes.iconLg * 1.2,
                      child: Center(child: Icon(Iconsax.add,color: TColors.white,))),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}


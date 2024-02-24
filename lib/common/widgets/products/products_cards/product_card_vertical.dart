import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/styles/shadows.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/common/widgets/images/t_roundec_images.dart';
import 'package:tstore/common/widgets/text/t_brand_title_text_with_verfied_icon.dart';
import 'package:tstore/features/shop/controller/products/product_controller.dart';
import 'package:tstore/features/shop/view/product_detail/product_detail.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../features/shop/model/product_model.dart';
import '../../../../utils/constants/enums.dart';
import '../../icons/t_circular_icon.dart';
import '../../text/t_brand_title_text.dart';
import '../../text/t_product_price_text.dart';
import '../../text/t_product_tile_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});
final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller=ProductController.instance;
    final salesPercentage=controller.calculateSalePercentage(product.price!, product.salePrice);

    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: (){
        Get.to(()=>  ProductDetail(product: product,));
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
            Center(
              child: TRoundedContainer(
                height: 180,
                width: 180,
                padding: const EdgeInsets.all(TSizes.md),
                bgColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    ///Thumbnail Image
                     Center(
                      child: TRoundedImage(
                        imageUrl: product.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true,
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
                          '$salesPercentage%',
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
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems/2,
            ),



            ///Detail Section

             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TProductTileText(
                  title: product.title,
                  smallSize: true,
                ),

                SizedBox(height: TSizes.spaceBtwItems/2,),

                TBrandTitleWithVerifyIcon(title: product.brand!.name),



              ],
            ),
            const Spacer(),

            /// Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                 Flexible(
                   child: Column(
                     children: [
                       if(product.productType == ProductType.single.toString() && product.salePrice>0)
                         Padding(
                           padding: EdgeInsets.only(left:TSizes.sm),
                           child: Text(product.price.toString(),
                           style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),)
                         ),

                       Padding(
                        padding: EdgeInsets.only(left:TSizes.sm),
                        child: TProductPriceText(
                          price: controller.getProductPrice(product),
                        ),
                ),
                     ],
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


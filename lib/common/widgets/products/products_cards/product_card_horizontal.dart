import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/images/t_roundec_images.dart';
import 'package:tstore/common/widgets/products/favourite/favourite_icon.dart';
import 'package:tstore/common/widgets/text/t_brand_title_text_with_verfied_icon.dart';
import 'package:tstore/common/widgets/text/t_product_price_text.dart';
import 'package:tstore/common/widgets/text/t_product_tile_text.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/image_strings.dart';

import '../../../../features/shop/controller/products/product_controller.dart';
import '../../../../features/shop/model/product_model.dart';
import '../../../../features/shop/view/product_detail/product_detail.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});


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
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.softGrey),
        child: Row(
          children: [
            /// Thumbnail
            TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              bgColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  /// Thumbnail Image
                   SizedBox(
                      width: 120,
                      height: 120,
                      child:   TRoundedImage(
                        imageUrl: product.thumbnail,
                        applyImageRadius: true,
                        isNetworkImage: true,
                      ),),

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
                    child: TFavouriteIcon(productId: product.id,)
                  )
                ],
              ),
            ),

            /// Details
             SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTileText(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        TBrandTitleWithVerifyIcon(title: product.brand!.name),
                      ],
                    ),

                    const Spacer(),

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
            )
          ],
        ),
      ),
    );
  }
}

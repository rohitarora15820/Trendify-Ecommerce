import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/images/t_circular_image.dart';
import 'package:tstore/common/widgets/text/t_brand_title_text_with_verfied_icon.dart';
import 'package:tstore/common/widgets/text/t_product_price_text.dart';
import 'package:tstore/common/widgets/text/t_product_tile_text.dart';
import 'package:tstore/features/shop/controller/products/product_controller.dart';
import 'package:tstore/utils/constants/enums.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../model/product_model.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price!, product.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            //Sales Tag
            TRoundedContainer(
              radius: TSizes.sm,
              bgColor: TColors.secondary.withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: Colors.black),
              ),
            ),

            ///Price Tag
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)   const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            TProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        /// Title
         TProductTileText(title: product.title),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        /// Stock Status
        Row(
          children: [
            const TProductTileText(title: 'Status'),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              controller.getProductStock(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        /// Brand
        Row(
          children: [
            TCircularImage(

              image:product.brand != null? product.brand!.image:"",
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black,
            ),
             TBrandTitleWithVerifyIcon(
              title:product.brand != null? product.brand!.name:"",
              brandTextSizes: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tstore/features/shop/model/cart_item_model.dart';
import 'package:tstore/routes/routes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_roundec_images.dart';
import '../../text/t_brand_title_text_with_verfied_icon.dart';
import '../../text/t_product_tile_text.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key, required this.cartItemModel,
  });
final CartItemModel cartItemModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          isNetworkImage: true,
          imageUrl: cartItemModel.image??"",
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          bgColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const  SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        ///Title ,Price
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TBrandTitleWithVerifyIcon(title: cartItemModel.brandName),
               Flexible(
                child: TProductTileText(
                  title: cartItemModel.title,
                  maxLines: 1,
                ),
              ),
              /// Attributes
              Text.rich(
                  TextSpan(
                      children: (cartItemModel.selectedVariation??{}).entries.map((e) => TextSpan(children:
                      [
                        TextSpan(
                            text: '${e.key}',
                            style: Theme.of(context).textTheme.bodySmall
                        ),TextSpan(
                            text: '${e.value}',
                            style: Theme.of(context).textTheme.bodyLarge
                        ),
                      ]
                      )).toList()
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}

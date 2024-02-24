import 'package:flutter/material.dart';

import '../../../features/shop/model/brand_model.dart';
import '../../../features/shop/view/shop/widgtes/brand_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key, required this.images,
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      bgColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
           TBrandCard(
             brand: BrandModel.empty(),
            showBorder: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: images.map((e) => brandTopProductImageWidget(e, context)).toList(),
          )
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image,context){
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(TSizes.md),
      bgColor: THelperFunctions.isDarkMode(context)
          ? TColors.darkerGrey
          : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      child: Image(
        fit: BoxFit.contain,
        image: AssetImage(image),
      ),
    ),
  );
}

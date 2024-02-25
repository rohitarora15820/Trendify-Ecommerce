import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/features/shop/view/brands/brand_products.dart';

import '../../../features/shop/model/brand_model.dart';
import '../../../features/shop/view/shop/widgtes/brand_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key, required this.images, required this.brand,
  });

  final BrandModel brand;
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.to(()=> BrandProducts(brand: brand)),
      child: TRoundedContainer(
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
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, progress) =>const  TShimmerLoader(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      )
    ),
  );
}

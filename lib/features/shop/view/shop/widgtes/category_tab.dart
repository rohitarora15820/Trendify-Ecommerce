import 'package:flutter/material.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/model/category_model.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              const TBrandShowcase(images: [
                TImages.productImage3,
                TImages.productImage2,
                TImages.productImage1,

              ],), const TBrandShowcase(images: [
                TImages.productImage3,
                TImages.productImage2,
                TImages.productImage1,

              ],),

              /// Products
              TSectionHeading(title: 'You might like',showActionButton: true,onPressed: (){},),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              // TGridLayout(itemCount: 4, itemBuilder: (p0, p1) => const TProductCardVertical(),)
            ],
          ),
        ),
      ],

    );
  }
}

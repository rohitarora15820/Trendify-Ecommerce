import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/model/category_model.dart';
import 'package:tstore/features/shop/view/all_products/all_products.dart';
import 'package:tstore/features/shop/view/shop/widgtes/category_brands.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controller/category_controller.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(categoryModel: category),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: VerticalProductShimmer());
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return Column(
                      children: [
                        TSectionHeading(
                          title: 'You might like',
                          showActionButton: true,
                          onPressed: () {
                            Get.to(() => AllProductsScreen(
                                  title: category.name,
                                  futureMethod: controller.getCategoryProducts(
                                      categoryId: category.id, limit: -1),
                                ));
                          },
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (p0, p1) => TProductCardVertical(
                            product: products[p1],
                          ),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

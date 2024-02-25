import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:tstore/common/widgets/shimmer/listtile_shimmer.dart';
import 'package:tstore/features/shop/controller/brand_controller.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../model/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandCategory(categoryModel.id),
        builder: (context, snapshot) {
          /// Loader
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );

          final widget = TCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          final brands = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: brands.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return  FutureBuilder(
                future: controller.getBrandProducts( brandId: brand.id,),
                builder: (context, snapshot) {

                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  final products=snapshot.data!;
                  return TBrandShowcase(
                    images: products.map((e) => e.thumbnail).toList(), brand: brand,
                  );
                }
              );
            },
          );
        });
  }
}

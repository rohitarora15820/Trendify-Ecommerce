import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/controller/brand_controller.dart';
import 'package:tstore/features/shop/model/brand_model.dart';
import 'package:tstore/features/shop/view/brands/brand_products.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../common/widgets/shimmer/brand_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../shop/widgtes/brand_card.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text(
          'Brand',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// List of brands
              Obx(() {
                if (controller.isLoading.value) {
                  return const TBrandShimmer();
                }
                if (controller.allBrands.isEmpty) {
                  return Center(
                      child: Text(
                        "No Data Found!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.white),
                      ));
                }
                return TGridLayout(
                  mainAxisExtent: 80,
                  itemCount: controller.allBrands.length,
                  itemBuilder: (p0, p1) {
                    final brand = controller.allBrands[p1];
                    return TBrandCard(
                      brand: brand,
                      onTap: () {
                        Get.to(() =>  BrandProducts(brand: brand,));
                      },
                      showBorder: true,
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

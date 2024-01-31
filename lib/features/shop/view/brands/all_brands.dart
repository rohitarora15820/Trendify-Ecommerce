import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/view/brands/brand_products.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../shop/widgtes/brand_card.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text(
          'Brand',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const TSectionHeading(title: 'Brands',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// List of brands
              TGridLayout(
                mainAxisExtent: 80,
                itemCount: 5, itemBuilder: (p0, p1) =>  TBrandCard(
                onTap: (){
                  Get.to(()=> const BrandProducts());
                },
                showBorder: true,


              ),)
            ],
          ),
        ),
      ),
    );
  }
}

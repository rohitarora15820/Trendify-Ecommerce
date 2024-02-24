import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/products/sortable/sortable_products.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/features/shop/controller/brand_controller.dart';
import 'package:tstore/features/shop/model/brand_model.dart';
import 'package:tstore/features/shop/view/shop/widgtes/brand_card.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});


  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller=BrandController.instance;
    return  Scaffold(
      appBar: TAppBar(
        title: Text(
         brand.name,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
            TBrandCard(showBorder: true, brand: brand,),
              SizedBox(height: TSizes.spaceBtwSections,),

              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {

                  const loader=VerticalProductShimmer();
                  final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget != null) return widget;

                  final brandedProducts=snapshot.data!;
                  return TSortableProducts(products: brandedProducts,);
                }
              )
            ],
          ),
        ),
      ),
    );

  }
}

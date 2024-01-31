import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/products/sortable/sortable_products.dart';
import 'package:tstore/features/shop/view/shop/widgtes/brand_card.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text(
          'Nike',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
            TBrandCard(showBorder: true),
              SizedBox(height: TSizes.spaceBtwSections,),

              TSortableProducts()
            ],
          ),
        ),
      ),
    );

  }
}

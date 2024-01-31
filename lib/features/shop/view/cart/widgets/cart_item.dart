import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/text/t_product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,  this.showAddRemoveButton=true,
  });

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemCount: 2,
      itemBuilder: (context, index) => Column(
        children: [
          const TCartItem(),
      if(showAddRemoveButton)    const SizedBox(height: TSizes.spaceBtwItems),

          /// Add/ Remove Button
          if(showAddRemoveButton)  const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 70,),
                  TProductQuantityWithAddAndRemove(),
                ],
              ),

              TProductPriceText(price: '256')

            ],
          )
        ],
      ),
    );
  }
}


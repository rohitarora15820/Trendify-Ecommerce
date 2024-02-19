import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../layout/t_grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// DropDown
        DropdownButtonFormField(
          decoration:const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sales',
            'Newest',
            'Popularity',
          ]
              .map((options) =>
              DropdownMenuItem(value: options, child: Text(options)))
              .toList(),
          onChanged: (v) {},
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        /// Products
        // TGridLayout(itemCount: 3, itemBuilder: (p0, p1) => const TProductCardVertical(),)
      ],
    );
  }
}
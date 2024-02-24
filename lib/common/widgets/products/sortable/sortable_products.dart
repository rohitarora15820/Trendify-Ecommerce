import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controller/products/all_product_controller.dart';
import '../../../../features/shop/model/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../layout/t_grid_layout.dart';
import '../products_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });
final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AllPProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// DropDown
        DropdownButtonFormField(
          value: controller.selectedSortOption.value,
          decoration:const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sales',
            'Newest',

          ]
              .map((options) =>
              DropdownMenuItem(value: options, child: Text(options)))
              .toList(),
          onChanged: (v) {
            controller.sortProducts(v!);
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        /// Products
        Obx(()=> TGridLayout(itemCount: controller.products.length, itemBuilder: (p0, p1) =>TProductCardVertical(product: controller.products[p1],),))
      ],
    );
  }
}
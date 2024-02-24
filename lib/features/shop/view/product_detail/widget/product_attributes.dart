import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/common/widgets/text/t_product_price_text.dart';
import 'package:tstore/common/widgets/text/t_product_tile_text.dart';
import 'package:tstore/features/shop/controller/variation_controller.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../model/product_model.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(()=>
    Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)

          /// Selected Attribute Pricing & Description
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            bgColor: dark ? TColors.darkerGrey : TColors.grey,
            child: Column(
              children: [
                /// Title, Price and Stock
                Row(
                  children: [
                    const TSectionHeading(
                      title: 'Variation',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TProductTileText(
                              title: 'Price ',
                              smallSize: true,
                            ),
                            if (controller.selectedVariation.value.salePrice > 0)

                              /// Actual Price
                              Text(
                                '\$${controller.selectedVariation.value.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),

                            /// Sale Price
                             TProductPriceText(price: controller.getVariationPrice())
                          ],
                        ),

                        ///Stock
                        Row(
                          children: [
                            const TProductTileText(
                              title: 'Stock',
                              smallSize: true,
                            ),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                /// Variation Description
                 TProductTileText(
                  title:
                      controller.selectedVariation.value.description!,
                  smallSize: true,
                  maxLines: 4,
                )
              ],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(title: attribute.name!),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            children: attribute.values!.map((value) {
                              final isSelected =
                                  controller.selectedAttributes[attribute.name] ==
                                      value;

                              final available = controller
                                  .getAttributeAvaliablityInVariation(
                                      product.productVariations!, attribute.name!)
                                  .contains(value);
                              return TChoiceChip(
                                text: value,
                                selected: isSelected,
                                onSelected: available
                                    ? (v) {
                                        if (available && v) {
                                          controller.onAttributeSelected(
                                              product, attribute.name, value);
                                        }
                                      }
                                    : null,
                              );
                            }).toList(),
                            // children: [
                            //   TChoiceChip(
                            //     text: "Green",
                            //     selected: false,
                            //     onSelected: (v) {},
                            //   ),
                            //   TChoiceChip(
                            //     text: "Blue",
                            //     selected: true,
                            //     onSelected: (v) {},
                            //   ),
                            //   TChoiceChip(
                            //     text: "Yellow",
                            //     selected: false,
                            //     onSelected: (v) {},
                            //   ),
                            // ],
                          ),
                        )
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

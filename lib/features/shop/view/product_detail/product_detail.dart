import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/features/shop/view/product_detail/widget/bottom_add_to_cart.dart';
import 'package:tstore/features/shop/view/product_detail/widget/product_attributes.dart';
import 'package:tstore/features/shop/view/product_detail/widget/product_meta_data.dart';
import 'package:tstore/features/shop/view/product_detail/widget/rating_share_widget.dart';
import 'package:tstore/features/shop/view/product_detail/widget/tproducImageSlider.dart';
import 'package:tstore/features/shop/view/product_review/product_review.dart';
import 'package:tstore/utils/constants/enums.dart';

import '../../../../utils/constants/sizes.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  TBottomAddToCart(product:product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            TProductImageSlider(
              product: product,
            ),

            /// Product Details
            Padding(
              padding: const EdgeInsets.only(
                left: TSizes.defaultSpace,
                right: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating & Share
                   TRatingAndShare(
                     productModel: product,
                   ),

                  /// Price,Title,Stock & Brand
                  ProductMetaData(
                    product: product,
                  ),

                  /// Attributes
                  if (product.productType == ProductType.variable.toString())
                    ProductAttributes(
                      product: product,
                    ),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                  /// Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Checkout"))),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// Description
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description!,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show More',
                    trimExpandedText: 'Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews
                  const Divider(),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews(99)',
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const ProductReviewScreen());
                          },
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

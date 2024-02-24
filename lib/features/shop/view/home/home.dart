import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/features/shop/controller/products/product_controller.dart';
import 'package:tstore/features/shop/view/all_products/all_products.dart';
import 'package:tstore/features/shop/view/home/widgets/home_appbar.dart';
import 'package:tstore/features/shop/view/home/widgets/home_categories.dart';

// import 'package:tstore/features/shop/view/widgets/home_categories.dart';
import 'package:tstore/features/shop/view/home/widgets/promo_slider.dart';
import 'package:tstore/utils/constants/sizes.dart';
import '../../../../common/layout/t_grid_layout.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //Appbar
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Search Bar
                  TSearchContainer(
                    txt: "Search in Store",
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //Heading Section
                        TSectionHeading(
                          title: "Product Categories",
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        //ScrollableCategoriesSection
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            /// Body section
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //Heading Section
                    TSectionHeading(
                      title: "Popular Products",
                      onPressed: () {
                        Get.to(() =>  AllProductsScreen(
                          title: "Popular Products",
                          query: FirebaseFirestore.instance.collection('Products').where('IsFeatured',isEqualTo: true).limit(2),
                        ));
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx(() {
                      if (controller.isLoading.value)
                        return const VerticalProductShimmer();

                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            "No Data Found!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      }

                      return TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (p0, index) =>
                            TProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

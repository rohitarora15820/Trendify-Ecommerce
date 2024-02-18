import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/custom_appbar/tabBar.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:tstore/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/controller/category_controller.dart';
import 'package:tstore/features/shop/view/brands/all_brands.dart';
import 'package:tstore/features/shop/view/shop/widgtes/brand_card.dart';
import 'package:tstore/features/shop/view/shop/widgtes/category_tab.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    final category = CategoryController.instance.featuredCategoryList;
    return DefaultTabController(
      length: category.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search Bar

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      const TSearchContainer(
                        txt: 'Search in Store',
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        showBorder: true,
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// Feature Brand
                      TSectionHeading(
                        title: 'Featured Brand',
                        showActionButton: true,
                        onPressed: () {
                          Get.to(() => const AllBrandsScreen());
                        },
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      TGridLayout(
                        mainAxisExtent: 80,
                        itemCount: 4,
                        itemBuilder: (p0, p1) => const TBrandCard(
                          showBorder: false,
                        ),
                      )
                    ],
                  ),
                ),
                bottom: TTabBar(
                    tabs: category
                        .map(
                          (element) => Tab(
                            child: Text(element.name),
                          ),
                        )
                        .toList()))
          ],
          body:  TabBarView(
            children: category.map((element) => TCategoryTab(category: element,)).toList(),
          ),
        ),
      ),
    );
  }
}

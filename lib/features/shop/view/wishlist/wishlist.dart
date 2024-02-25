import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/common/widgets/icons/t_circular_icon.dart';
import 'package:tstore/common/widgets/loaders/anmation_loaders.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/features/shop/controller/products/favourite_controller.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/features/shop/view/home/home.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/cloud_helper_functions.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "WishList",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(()=>
                 FutureBuilder(
                    future: controller.getFavouritesProduct(),
                    builder: (context, snapshot) {
                      final emptyWidget = TAnimationLoaderWidget(
                        text: 'Whoops! WishList is Empty',
                        animation: TImages.wishListIllustration,
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressd: () => Get.offAll(() => const NavigationMenu()),
                      );
                      const loader = VerticalProductShimmer();
                      final widget = TCloudHelperFunctions.checkMultiRecordState(
                          snapshot: snapshot, loader: loader,nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;

                      return TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (p0, p1) => TProductCardVertical(
                          product: products[p1],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

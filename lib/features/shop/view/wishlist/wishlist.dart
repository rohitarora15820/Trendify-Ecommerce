import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/common/widgets/icons/t_circular_icon.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:tstore/features/shop/view/home/home.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("WishList",style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          TCircularIcon(icon: Iconsax.add, dark: THelperFunctions.isDarkMode(context),
          onPressed: ()=>Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(itemCount: 4, itemBuilder: (p0, p1) => const TProductCardVertical(),)
            ],
          ),
        ),
      ),
    );
  }
}

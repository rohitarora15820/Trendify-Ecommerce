import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/icons/t_circular_icon.dart';
import 'package:tstore/features/shop/controller/products/favourite_controller.dart';
import 'package:tstore/utils/constants/colors.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});
final String productId;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(FavouriteController());
    return  Obx(()=>
      TCircularIcon(
        icon:controller.isFavourite(productId)? Iconsax.heart5:Iconsax.heart,
        color:controller.isFavourite(productId)?TColors.error:null,
        onPressed:()=> controller.toggleFavouriteProduct(productId),
      ),
    );


  }
}

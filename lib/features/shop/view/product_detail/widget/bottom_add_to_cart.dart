import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/icons/t_circular_icon.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: Obx(()=>
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

               Row(
                children: [
                  TCircularIcon(
                    icon: Iconsax.minus,
                    bgColor: TColors.darkGrey,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                    onPressed: () => controller.productQtyInCart.value < 0
                        ? null
                        : controller.productQtyInCart.value -= 1,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Text(
                    controller.productQtyInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  TCircularIcon(
                    onPressed: ()=> controller.productQtyInCart += 1,
                    icon: Iconsax.add,
                    bgColor: TColors.black,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                  ),
                ],
              ),

            ElevatedButton(
                onPressed: controller.productQtyInCart.value < 1 ? null:()=> controller.addToCart(product),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: TColors.black,
                    side: const BorderSide(color: TColors.black)),
                child: const Text('Add To Cart'))
          ],
        ),
      ),
    );
  }
}

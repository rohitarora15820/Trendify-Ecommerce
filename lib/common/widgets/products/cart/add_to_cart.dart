import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/view/product_detail/product_detail.dart';

import '../../../../features/shop/model/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return GestureDetector(
      onTap: () {
        // if product have variation then show product details for variation selection

        // else add product to cart
        if (product.productType == ProductType.single.toString()) {
          final cartItem = controller.convertToCartItem(product, 1);
          controller.addOneToCart(cartItem);
        } else {
          Get.to(()=> ProductDetail(product: product));
        }
      },
      child: Obx(() {
        final qtyInCart = controller.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
              color: qtyInCart > 0 ? TColors.primary : TColors.dark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(TSizes.cardRadiusMd),
                bottomRight: Radius.circular(TSizes.productImageRadius),
              )),
          child: SizedBox(
              width: TSizes.iconLg * 1.2,
              height: TSizes.iconLg * 1.2,
              child: Center(
                  child: qtyInCart > 0
                      ? Text(
                          qtyInCart.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: TColors.white),
                        )
                      : Icon(
                          Iconsax.add,
                          color: TColors.white,
                        ))),
        );
      }),
    );
  }
}

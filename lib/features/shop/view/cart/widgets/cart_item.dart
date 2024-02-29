import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/text/t_product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,  this.showAddRemoveButton=true,
  });

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controller=CartController.instance;
    return Obx(()=>
       ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) => Obx((){
          final item=controller.cartItems[index];
          return  Column(
            children: [
               TCartItem(cartItemModel: item,),
              if(showAddRemoveButton)    const SizedBox(height: TSizes.spaceBtwItems),

              /// Add/ Remove Button
              if(showAddRemoveButton)   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70,),
                      TProductQuantityWithAddAndRemove(
                        quantity: item.quantity,
                        add:()=> controller.addOneToCart(item),
                        remove:()=> controller.removeOneToCart(item),
                      ),
                    ],
                  ),

                  TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1))

                ],
              )
            ],
          );
        }

        ),
      ),
    );
  }
}


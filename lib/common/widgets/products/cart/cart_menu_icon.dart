
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/view/cart/cart.dart';

import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,

    this.iconColor,
  });


  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CartController());
    return Stack(
      children: [
        IconButton(
            onPressed: ()=> Get.to(()=> CartPage()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100)),
              child:  Obx(()=>
                 Center(
                  child: Text(
                    controller.noOfCartItems.value.toString(),
                    style: TextStyle(color: Colors.white,fontSize: 10),
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .labelLarge!
                    //     .apply(color:Colors.white, fontSizeFactor: 0.0),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

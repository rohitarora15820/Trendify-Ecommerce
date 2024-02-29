import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/loaders/anmation_loaders.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/view/cart/widgets/cart_item.dart';
import 'package:tstore/features/shop/view/checkout/checkout.dart';
import 'package:tstore/navigation_menu.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../utils/constants/image_strings.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: "Whhops! Cart is EMPTY",
          animation: TImages.cartIllustration,
          showAction: true,
          actionText: "Let\'s fill it",
          onActionPressd: () => Get.offAll(() => NavigationMenu()),
        );
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(
                showAddRemoveButton: true,
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CheckoutPage());
                },
                child: Obx(() =>
                    Text('Checkout \$${controller.totalCartPrice.value}')),
              ),
            ),
    );
  }
}

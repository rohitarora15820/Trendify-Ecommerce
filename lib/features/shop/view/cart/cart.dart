import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/view/cart/widgets/cart_item.dart';
import 'package:tstore/features/shop/view/checkout/checkout.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItems(
          showAddRemoveButton: true,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const CheckoutPage());
          },
          child: const Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}

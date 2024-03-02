import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/sucess_screen/sucess_screen.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/view/cart/widgets/cart_item.dart';
import 'package:tstore/features/shop/view/checkout/widgets/billing_address_section.dart';
import 'package:tstore/features/shop/view/checkout/widgets/billing_amount_section.dart';
import 'package:tstore/features/shop/view/checkout/widgets/billing_payment_section.dart';
import 'package:tstore/navigation_menu.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';
import 'package:tstore/utils/helpers/pricing_calculator.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/products/order_controller.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'us');
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const TCartItems(
                showAddRemoveButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Coupon TextField
              const TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                bgColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Divider
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Payment Methods
                    BillingPaymentSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Addresses
                    BillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrders(totalAmount)
              : () => TLoaders.warningSnackBar(
                  title: "Empty Cart",
                  message: "Add items in the cart in order to proceed"),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}

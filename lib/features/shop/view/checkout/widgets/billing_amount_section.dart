import 'package:flutter/material.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/pricing_calculator.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=CartController.instance;
    final subTotal=controller.totalCartPrice.value;
    return Column(
      children: [
        /// Subtotal
        Row(
          children: [
            Expanded(child: Text('SubTotal',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('₹ $subTotal',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Shipping Fee
        Row(
          children: [
            Expanded(child: Text('Shipping Fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('₹ ${TPricingCalculator.calculateShippingCost(subTotal, 'us')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Tax Fee
        Row(
          children: [
            Expanded(child: Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('₹ ${TPricingCalculator.calculateTax(subTotal, 'us')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Order Total
        Row(
          children: [
            Expanded(child: Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('₹ ${TPricingCalculator.calculateTotalPrice(subTotal, 'us').toStringAsFixed(1)}',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ],
    );
  }
}

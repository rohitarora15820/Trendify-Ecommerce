import 'package:flutter/material.dart';
import 'package:tstore/utils/constants/sizes.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Subtotal
        Row(
          children: [
            Expanded(child: Text('SubTotal',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$256.0',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Shipping Fee
        Row(
          children: [
            Expanded(child: Text('Shipping Fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$6.0',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Tax Fee
        Row(
          children: [
            Expanded(child: Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$6.0',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems/2,
        ),
        /// Order Total
        Row(
          children: [
            Expanded(child: Text('Order Total',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$6.0',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ],
    );
  }
}

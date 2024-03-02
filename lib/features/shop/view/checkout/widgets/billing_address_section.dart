import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/address_controller.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../../common/widgets/text/section_heading.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () {
            controller.selectNewAddressPopup(context);
          },
        ),
        controller.selectedAddress.value.id.isNotEmpty
            ? Obx(()=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.selectedAddress.value.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Text(
                          controller.selectedAddress.value.formattedPhoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwItems,
                        ),
                        Flexible(
                          child: Text(
                            
                            controller.selectedAddress.value.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                  ],
                ),
            )
            : Text("Select Address",style: Theme.of(context).textTheme.bodyMedium,)
      ],
    );
  }
}

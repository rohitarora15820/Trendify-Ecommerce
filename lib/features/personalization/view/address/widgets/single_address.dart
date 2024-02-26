import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/features/shop/controller/address_controller.dart';
import 'package:tstore/features/shop/model/address_model.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap, });

  final AddressModel address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller=AddressController.instance;

    return Obx(() {
      final selectedAddressId=controller.selectedAddress.value.id;
      final selectedAddress=selectedAddressId == address.id;
      return
      GestureDetector(
        onTap: onTap,
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          bgColor: selectedAddress
              ? TColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
              ? TColors.darkerGrey
              : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                        ? TColors.light
                        : TColors.dark.withOpacity(0.6)
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: TSizes.sm / 2,),
                   Text(address.formattedPhoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                  ),
                  const SizedBox(height: TSizes.sm / 2,),
                   Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),

                ],
              )
            ],
          ),
        ),
      );

    }
    );
  }
}

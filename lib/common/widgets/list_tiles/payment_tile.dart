import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/features/shop/controller/checkout/checkout_controller.dart';
import 'package:tstore/features/shop/model/payment_method_model.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../utils/constants/sizes.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.model});

  final PaymentMethodModel model;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return GestureDetector(
      onTap: () {
        controller.selectedPaymentMethod.value = model;
        Get.back();
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: TRoundedContainer(
          width: 60,
          height: 40,
          bgColor: THelperFunctions.isDarkMode(context)
              ? TColors.dark
              : TColors.light,
          padding: const EdgeInsets.all(TSizes.sm),
          child: Image(
            image: AssetImage(model.image),
            fit: BoxFit.contain,
          ),
        ),
        title: Text(model.name),
        trailing: Icon(Iconsax.arrow_right_34),
      ),
    );
  }
}

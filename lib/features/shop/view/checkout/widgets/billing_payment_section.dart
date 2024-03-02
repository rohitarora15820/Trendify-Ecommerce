import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/controller/checkout/checkout_controller.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CheckoutController());
    return Column(
      children: [
        TSectionHeading(title: 'Payment Method',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: (){
          controller.selectPaymentMethod(context);
          },
        ),
        Obx(()=>
           Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 35,
                bgColor: THelperFunctions.isDarkMode(context)?TColors.light:TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child:  Image(
                  image: AssetImage(controller.selectedPaymentMethod.value.image,)
                  ,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems/2,),
              Text(controller.selectedPaymentMethod.value.name,style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        )
      ],
    );
  }
}

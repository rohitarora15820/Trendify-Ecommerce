import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      bgColor: dark? TColors.dark:TColors.light,
      padding: const EdgeInsets.only(
        bottom: TSizes.sm,
        right: TSizes.sm,
        top: TSizes.sm,
        left: TSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Have a promo code? Enter here",
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),

            ),
          ),

          /// Button
          SizedBox(
              width: 70,

              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: dark?TColors.white.withOpacity(0.5):TColors.dark.withOpacity(0.5),
                      backgroundColor: TColors.grey.withOpacity(0.2),
                      side: BorderSide(color: Colors.grey.withOpacity(0.1))
                  ),
                  onPressed: (){}, child:const Text('Apply')))
        ],
      ),
    );
  }
}
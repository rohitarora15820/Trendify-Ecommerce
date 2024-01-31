
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingCircularButton extends StatelessWidget {
  const OnBoardingCircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return Positioned(
        right: TSizes.defaultSpace,
        bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor:dark?TColors.primary: Colors.black),
          child: const Icon(Iconsax.arrow_right_3),
          onPressed: ()=>onBoardingController.instance.nextPage(),
        ));
  }
}
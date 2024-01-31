import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.txt,
    this.icon=Iconsax.search_normal,
    this.showBackground=true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
    this.showBorder=true, this.onPressed,
  });

  final String txt;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function()? onPressed;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap:onPressed ,
      child: Padding(
        padding: padding!,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? darkMode
                  ? TColors.dark
                  : TColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              border:showBorder? Border.all(color: TColors.grey):null),
          child: Row(
            children: [
              Icon(
                icon,
                color: TColors.darkGrey,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                txt,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
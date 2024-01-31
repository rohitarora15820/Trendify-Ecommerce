
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.onPressed,
    this.iconColor,
  });

  final Function()? onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: const Center(
                child: Text(
                  '2',
                  style: TextStyle(color: Colors.white,fontSize: 10),
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .labelLarge!
                  //     .apply(color:Colors.white, fontSizeFactor: 0.0),
                ),
              ),
            ))
      ],
    );
  }
}

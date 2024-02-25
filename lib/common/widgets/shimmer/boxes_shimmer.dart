import 'package:flutter/material.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../loaders/shimmer_loader.dart';

class TBoxesShimmer extends StatelessWidget {
  const TBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TShimmerLoader(
              width: 150,
              height: 110,
            )),
            SizedBox(width: TSizes.spaceBtwItems,),
            Expanded(
                child: TShimmerLoader(
              width: 150,
              height: 110,
            )),
            SizedBox(width: TSizes.spaceBtwItems,),
            Expanded(
                child: TShimmerLoader(
              width: 150,
              height: 110,
            )),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/utils/constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerLoader(
              width: 50,
              height: 50,
              radius: 50,
            ),
            SizedBox(height: TSizes.spaceBtwItems,),
            Column(
              children: [
                TShimmerLoader(width: 100, height: 15),
                SizedBox(height: TSizes.spaceBtwItems/2),
                TShimmerLoader(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}

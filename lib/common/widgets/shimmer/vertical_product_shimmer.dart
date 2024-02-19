import 'package:flutter/material.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(itemCount: itemCount, itemBuilder: (p0, p1) =>
      SizedBox(
        width: 180,
        child: Column(
          children: [
            /// Image
            TShimmerLoader(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems,),
            /// Text
            TShimmerLoader(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems/2,),
            TShimmerLoader(width: 110, height: 15)
          ],
        ),
      )
      ,);
  }
}

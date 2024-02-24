import 'package:flutter/material.dart';
import 'package:tstore/common/layout/t_grid_layout.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/utils/constants/sizes.dart';

class TBrandShimmer extends StatelessWidget {
  const TBrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      itemBuilder: (p0, p1) => const TShimmerLoader(width: 300, height: 80),
    );
  }
}

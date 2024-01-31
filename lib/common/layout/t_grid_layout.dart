import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {


  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext,int) itemBuilder;
  const TGridLayout({
    super.key, required this.itemCount, this.mainAxisExtent=288, required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics:const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate:
       SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: TSizes.gridViewSpacing,
          crossAxisSpacing: TSizes.gridViewSpacing,
          mainAxisExtent: mainAxisExtent
      ),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}

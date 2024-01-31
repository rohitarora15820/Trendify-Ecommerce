import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/hom_controller.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_roundec_images.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((e) => TRoundedImage(imageUrl: e)).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
        ),
     const   SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  bgColor: controller.carousalCurrentIndex.value == i
                      ? Colors.green
                      : Colors.grey,
                  margin:const EdgeInsets.only(right: 10),
                ),
            ],
          ),
        )
      ],
    );
  }
}

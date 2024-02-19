import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/features/shop/controller/banner_controller.dart';
import 'package:tstore/features/shop/controller/hom_controller.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_roundec_images.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if(controller.bannerLoading.value) return const TShimmerLoader(width: double.infinity, height: 190);
      if (controller.bannerList.isEmpty) {
        return Center(
          child: Text(
            "No Data Found!",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        );
      }
      return Column(
        children: [
          CarouselSlider(
            items: controller.bannerList
                .map((e) => TRoundedImage(

                      imageUrl: e.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(e.targetScreen),
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < controller.bannerList.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    bgColor: controller.carousalCurrentIndex.value == i
                        ? Colors.green
                        : Colors.grey,
                    margin: const EdgeInsets.only(right: 10),
                  ),
              ],
            ),
          )
        ],
      );
    });
  }
}

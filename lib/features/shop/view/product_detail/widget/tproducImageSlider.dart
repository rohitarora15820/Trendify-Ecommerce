import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/products/favourite/favourite_icon.dart';
import 'package:tstore/features/shop/controller/products/image_controller.dart';

import '../../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/containers/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_roundec_images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../model/product_model.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductsImages(product);
    return TCurvedEdgesContainer(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Screen Image
            SizedBox(
                height: 400,
                child: Padding(
                    padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                    child: Center(child: Obx(() {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargeImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (context, url, progress) =>
                              CircularProgressIndicator(
                            value: progress.progress,
                            color: TColors.primary,
                          ),
                        ),
                      );
                    })))),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Obx(() {
                    final selectImage =
                        controller.selectedProductImage.value == images[index];
                    return TRoundedImage(
                        onPressed: () => controller.selectedProductImage.value =
                            images[index],
                        isNetworkImage: true,
                        width: 80,
                        bgColor: dark ? TColors.dark : TColors.white,
                        border: Border.all(
                            color: selectImage
                                ? TColors.primary
                                : Colors.transparent),
                        padding: const EdgeInsets.all(TSizes.sm),
                        imageUrl: images[index]);
                  }),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
                ),
              ),
            ),

            /// AppBar Icons
             TAppBar(
              showBackArrow: true,
              actions: [TFavouriteIcon(productId: product.id,)],
            )
          ],
        ),
      ),
    );
  }
}

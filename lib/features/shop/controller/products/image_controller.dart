import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/sizes.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  /// varibles
  RxString selectedProductImage = "".obs;

// Get All Images from product and variation
  List<String> getAllProductsImages(ProductModel product) {
    // Add Unique Images
    Set<String> images = {};

    // Add Thumbnails/ Main Image
    images.add(product.thumbnail);

    // Assign to Selected variables
    selectedProductImage.value = product.thumbnail;

    if (product.images != null) {
      images.addAll(product.images!);
    }

    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map((e) => e.image));
    }

    return images.toList();
  }

  /// Image Popup
  void showEnlargeImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        child: Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}

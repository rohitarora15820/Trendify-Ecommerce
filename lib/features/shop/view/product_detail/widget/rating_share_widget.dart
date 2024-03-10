import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/shop/controller/hom_controller.dart';
import 'package:tstore/features/shop/model/product_model.dart';

import '../../../../../data/services/firebase_dynamic_service.dart';
import '../../../../../utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key, required this.productModel,
  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(FirebaseDynamicLinkController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///Ratings
        Row(
          children: [
            const Icon(Iconsax.star5,
              color: Colors.amber,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems/2,
            ),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: '5.0',style: Theme.of(context).textTheme.bodyLarge),
                      const TextSpan(text: '(199)'),
                    ]
                )
            )
          ],
        ),

        ///Share
        IconButton(onPressed: (){
          controller.buildDynamicLink(productModel.title, productModel.thumbnail, productModel.id);
        }, icon: const Icon(Icons.share,size: TSizes.iconMd,))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/features/shop/view/product_review/widgets/overall_progress_indicator.dart';
import 'package:tstore/features/shop/view/product_review/widgets/user_review_card.dart';

import '../../../../common/widgets/products/rating_bar/rating_bar.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use.'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Overall Product Rating
              const TOverallProgressIndicator(),


              const TRatingBarIndicator(rating: 3.5,),
              Text('12,611',style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),


              /// User Review List
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}


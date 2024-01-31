import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/common/widgets/products/rating_bar/rating_bar.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage1),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  'Jon Doe',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Reviews
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              '04 Nov, 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        const ReadMoreText(
          'The user interface of app is quite interactive. I am able to navigate and make purchases seamlessly, Great Job',
          trimLines: 1,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primary),
          lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),


        /// Company Review
        TRoundedContainer(bgColor: dark? TColors.darkerGrey:TColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("T's Store",style: Theme.of(context).textTheme.titleMedium,),
                  Text("02 Nov, 2024",style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const ReadMoreText(
                'The user interface of app is quite interactive. I am able to navigate and make purchases seamlessly, Great Job',
                trimLines: 1,
                trimExpandedText: 'show less',
                trimCollapsedText: 'show more',
                trimMode: TrimMode.Line,
                moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primary),
                lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: TColors.primary),
              ),


            ],
          ),
        ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}

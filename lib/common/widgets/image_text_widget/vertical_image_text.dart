import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../loaders/shimmer_loader.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key, required this.title, required this.image, this.textColor=TColors.white, this.bgColor=TColors.white, this.onPressed, this.isNetworkImage=false,
  });


  final String title,image;
  final Color? textColor;
  final Color? bgColor;
  final void Function()? onPressed;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark=THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                  color:bgColor?? (dark?
                  TColors.black:TColors.white
                  ), borderRadius: BorderRadius.circular(100)),
              child: Center(
                child:
                isNetworkImage
                    ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  color:dark?
                  TColors.light: TColors.dark,
                  progressIndicatorBuilder: (context, url, progress) =>
                  const TShimmerLoader(
                    width: 55,
                    height: 55,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
                    :
                Image(
                  image: NetworkImage(image),
                  color:dark?
                  TColors.light: TColors.dark,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///Text
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}
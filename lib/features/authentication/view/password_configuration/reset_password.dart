import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: ()=> Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
            padding:  const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                  image:  const AssetImage(
                    TImages.deliveredEmailIllustration,
                  ),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Title & Subtitle
              Text(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(TTexts.done),
                  onPressed:(){},
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Buttons
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  child: const Text(TTexts.resendEmail),
                  onPressed:(){},
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

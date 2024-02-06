import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/authentication/controller/forgot_password/forgot_password_controller.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../login/login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key,required this.email});

  final String email;

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

              ///Email
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
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
                  onPressed:(){
                    Get.offAll(()=> LoginScreen());
                  },
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
                  onPressed:(){
                    ForgotPasswordController.instance.resendPasswordResetEmail(email);
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

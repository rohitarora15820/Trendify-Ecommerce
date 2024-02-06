import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/authentication/controller/forgot_password/forgot_password_controller.dart';
import 'package:tstore/features/authentication/view/password_configuration/reset_password.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/validators/validation.dart';

import '../../../../utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(ForgotPasswordController() );
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// heading
            Text(TTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text(TTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSections * 2,),

            /// text field
            Form(
              key: controller.forgotPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText:TTexts.email,
                prefixIcon:Icon( Iconsax.direct_right)
                )
                ),
            ),

            /// submit button
            const SizedBox(height: TSizes.spaceBtwSections ,),
            SizedBox(width: double.infinity,
            child: ElevatedButton(

              onPressed: (){
               controller.sendPasswordResetEmail();
              },
              child: const Text(TTexts.submit),
            ),)

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/authentication/view/password_configuration/forgot_password.dart';
import 'package:tstore/navigation_menu.dart';


import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../signup/signup.dart';

class login_form extends StatelessWidget {
  const login_form({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            //Remember me and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (v) {}),
                    const Text(TTexts.rememberMe)
                  ],
                ),

                //Forget Password
                TextButton(
                    onPressed: () {
                      Get.to(()=> const ForgetPassword());
                    }, child: const Text(TTexts.forgetPassword)),
              ],
            ),
            //Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {Get.to(()=>  const NavigationMenu());}, child: const Text(TTexts.signIn))),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            //Create Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => const SignUp());
                    },
                    child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}

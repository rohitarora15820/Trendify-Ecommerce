import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/login_signup/form_divider.dart';
import 'package:tstore/common/widgets/login_signup/social_buttons.dart';
import 'package:tstore/features/authentication/view/signup/widgets/signup_form.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/constants/text_strings.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Form
              SignUpForm(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),


              ///Divider
               TFormDivider(
              dividerText: TTexts.orSignUpWith.capitalize!,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),


              ///Social Buttons
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}


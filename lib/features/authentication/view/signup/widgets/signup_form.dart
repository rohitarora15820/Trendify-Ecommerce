import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/authentication/controller/signup/signup_controller.dart';
import 'package:tstore/features/authentication/view/signup/verify_email.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) {
                    return TValidator.validateEmptyText('First Name', value);
                  },
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) {
                    return TValidator.validateEmptyText('Last Name', value);
                  },
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// UserName
          TextFormField(
            controller: controller.username,
            validator: (value) {
              return TValidator.validateEmptyText('User Name', value);
            },
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) {
              return TValidator.validateEmail(value);
            },
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) {
              return TValidator.validatePhoneNumber(value);
            },
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          ///Passwword
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              validator: (value) {
                return TValidator.validatePassword(value);
              },
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Terms & Condition
          Row(
            children: [
              Obx(()=>
                 SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(value: controller.privacyPolicy.value, onChanged: (v) {
                      controller.privacyPolicy.value = v!;
                    })),
              ),
              const SizedBox(
                width: TSizes.dividerHeight,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: '${TTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: '${TTexts.privacyPolicy} ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? Colors.white : TColors.primary,
                          decorationColor:
                              dark ? Colors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        )),
                TextSpan(
                    text: '${TTexts.and} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: '${TTexts.termsOfUse} ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? Colors.white : TColors.primary,
                          decorationColor:
                              dark ? Colors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        )),
              ])),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          ///Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.signup();
              },
              child: const Text(TTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}

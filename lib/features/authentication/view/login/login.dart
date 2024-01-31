import 'package:flutter/material.dart';
import 'package:tstore/common/styles/spacing_styles.dart';
import 'package:tstore/features/authentication/view/login/widgets/login_divider.dart';
import 'package:tstore/features/authentication/view/login/widgets/login_footer.dart';
import 'package:tstore/features/authentication/view/login/widgets/login_form.dart';
import 'package:tstore/features/authentication/view/login/widgets/login_header.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title and Subtitle
              login_header(dark: dark),

              /// Form
              const login_form(),

              /// Divider
              login_divider(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Footer
              const login_footer()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/authentication/view/onboarding/widgets/onboarding_circularbutton.dart';
import 'package:tstore/features/authentication/view/onboarding/widgets/onboarding_dotnavigation.dart';
import 'package:tstore/features/authentication/view/onboarding/widgets/onboarding_page.dart';
import 'package:tstore/features/authentication/view/onboarding/widgets/onboarding_skip.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/text_strings.dart';

import '../../controller/onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(onBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pagecontroller,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Skip Button

          const OnBoardingSkip(),

          /// Dot Navigator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingCircularButton()
        ],
      ),
    );
  }
}



import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/sucess_screen/sucess_screen.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/text_strings.dart';
import 'package:tstore/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email whenever Verify screen appears & Set Timer for auto redirect
  @override
  void onInit() {
    // TODO: implement onInit
    sendEmailVerfication();
    setTimerForVerification();
    super.onInit();
  }

  ///Send Email
  Future<void> sendEmailVerfication() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.sucessSnackBar(
          title: "Email Sent",
          message: "Please Check your inbox and verify your email");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  ///Timer for auto redirect
  setTimerForVerification() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = await FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: TImages.suceesfullyRegisteredAnimation,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  ///Manually Check email verification
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: TImages.suceesfullyRegisteredAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}

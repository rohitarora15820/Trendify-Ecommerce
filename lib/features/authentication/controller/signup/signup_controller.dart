import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/data/repositories/user/user_repository.dart';
import 'package:tstore/features/authentication/view/signup/verify_email.dart';
import 'package:tstore/utils/helpers/network_manager.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loader.dart';
import '../../model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Signup
  Future<void> signup() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information...", TImages.loadingIllustration);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                "In Order to create account , you must have to read and accept the privacy policy & Terms of Use");
        return;
      }

      /// Register User in Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      ///  Save Data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        token: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      ///  Show Success Message
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your account has been created! Verify email to continue.");

      ///  Move to Verify Email Screen
      Get.to(() =>  VerifyEmailScreen(
        email: email.text.trim(),
      ));
    } catch (e) {
      TFullScreenLoader.stopLoading();

      /// Show More Generic Error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
